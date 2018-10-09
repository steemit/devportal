---
title: 'PY: Edit Content Patching'
position: 12
description: "How to edit post content with diff_match_patch using Python."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Edit Content Patching](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/12_edit_content_patching) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



In this tutorial we show you how to patch and update posts/comments on the **Steem** blockchain using the `commit` class found within the [steem-python](https://github.com/steemit/steem-python) library.

## Intro

Being able to patch a post is critical to save resources on Steem. The Steem python library has a built-in function to transmit transactions to the blockchain. We are using the `diff_match_patch` class for python to create a `patch` for a post or comment. We then use the `post` method found within the `commit` class in the library. It should be noted that comments and new post are both treated as `commit.post` operation with the only difference being that a comment/reply has got an additional parameter containing the `parent post/comment`. There is already a tutorial on how to create a new post so the focus of this tutorial will be on `patching` the content of the post. We will be using a couple of methods within the `diff_match_patch` class.

`diff_main` - This compares two text fields to find the differences.
`diff_cleanupSemantic` - This reduces the number of edits by eliminating semantically trivial equalities.
`diff_levenshtein` - Computes the Levenshtein distance: the number of inserted, deleted or substituted characters
`patch_make` - Creates a patch based on the calculated differences. This method can be executed in 3 different ways based on the parameters. By using the two separate text fields in question, by using only the calculated difference, or by using the original text along with the calculated difference.
`patch_apply` - This applies the created patch to the original text field.

## Steps

1.  [**App setup**](#setup) - Library install and import. Connection to testnet
1.  [**User information and steem node**](#userinfo) - Input user information and connection to Steem node
1.  [**Post to update**](#post) - Input and retrieve post information
1.  [**Patching**](#patch) - Create the patch to update the post
1.  [**New post commit**](#commit) - Commit the post to the blockchain

#### 1. App setup <a name="setup"></a>

In this tutorial we use 2 packages:

- `steem` - steem-python library and interaction with Blockchain
- `diff_match_patch` - used to compute the difference between two text fields to create a patch

We import the libraries and connect to the `testnet`.

```python
import steembase
import steem
from diff_match_patch import diff_match_patch

steembase.chains.known_chains['STEEM'] = {
    'chain_id': '79276aea5d4877d9a25892eaa01b0adf019d3e5cb12a97478df3298ccdd01673',
    'prefix': 'STX', 'steem_symbol': 'STEEM', 'sbd_symbol': 'SBD', 'vests_symbol': 'VESTS'
}
```

Because this tutorial alters the blockchain we connect to a testnet so we don't create spam on the production server.

#### 2. User information and steem node <a name="userinfo"></a>

We require the `private posting key` of the user in order for the transfer to be committed to the blockchain. This is why we are using a testnet. The values are supplied via the terminal/console before we initialise the steem class. There are some demo accounts available but we encourage you to create your own accounts on this testnet and create balances you can claim; it's good practice.

```python
#capture user information
username = input('Enter username: ') #demo account: cdemo
wif = input('Enter private POSTING key: ') #demo account: 5JEZ1EiUjFKfsKP32b15Y7jybjvHQPhnvCYZ9BW62H1LDUnMvHz

#connect node and private active key
client = steem.Steem(nodes=['https://testnet.steem.vc'], keys=[wif])
```

#### 3. Post to update <a name="post"></a>

The user inputs the author and permlink of the post that they wish to edit. It should be noted that a post cannot be patched once it has been archived. We suggest referring to the `submit post` tutorial to create a new post before trying the patch process.

```python
#check valid username
userinfo = client.get_account(username)
if(userinfo is None) :
    print('Oops. Looks like user ' + username + ' doesn\'t exist on this chain!')
    exit()

post_author = input('Please enter the AUTHOR of the post you want to edit: ')
post_permlink = input('Please enter the PERMLINK of the post you want to edit: ')

#get details of selected post
details = client.get_content(post_author, post_permlink)

print('\n' + 'Title: ' + details['title'])
o_body = details['body']
print('Body:' + '\n' + o_body + '\n')

n_body = input('Please enter new post content:' + '\n')
```

The user also inputs the updated text in the console/terminal. This will then give us the two text fields to compare.

#### 4. Patching <a name="patch"></a>

The module is initiated and the new post text is checked for validity.

```python
#initialise the diff match patch module
dmp = diff_match_patch()

#Check for null input
if (n_body == '') :
    print('\n' + 'No new post body supplied. Operation aborted')
    exit()
else :
    # Check for equality
    if (o_body == n_body) :
        print('\n' + 'No changes made to post body. Operation aborted')
        exit()
```

The `diff` is calculated and a test is done to check the `diff` length against the total length of the new text to determine if it will be better to patch or just replace the text field. The value to be sent to the blockchain is then assigned to the `new_body` parameter.

```python
#check for differences in the text field
diff = dmp.diff_main(o_body, n_body)
#Reduce the number of edits by eliminating semantically trivial equalities.
dmp.diff_cleanupSemantic(diff)
#check patch length
if (dmp.diff_levenshtein(diff) < len(o_body)) :
    #create patch
    patch = dmp.patch_make(o_body, diff)
    #create new text based on patch
    patch_body = dmp.patch_apply(patch, o_body)
    new_body = patch_body[0]
else :
    new_body = n_body
```

#### 5. New post commit <a name="commit"></a>

The only new parameter is the changed body text. All the other parameters to do a commit is assigned directly from the original post entered by the user.

```python
#commit post to blockchain with all old values and new body text
client.commit.post(title=details['title'], body=new_body, author=details['author'], permlink=details['permlink'],
    json_metadata=details['json_metadata'], reply_identifier=(details['parent_author'] + '/' + details['parent_permlink']))

print('\n' + 'Content of the post has been successfully updated')
```

A simple confirmation is displayed on the screen for a successful commit.

We encourage users to play around with different values and data types to fully understand how this process works. You can also check the balances and transaction history on the [testnet portal](http://condenser.steem.vc/).

### To Run the tutorial

1.  [review dev requirements](getting_started)
1.  clone this repo
1.  `cd tutorials/12_edit_content_patching`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.

---
