---
title: 'PY: Submit Post'
position: 10
description: 'How to submit post on Steem blockchain using Python.'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Submit Post](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/10_submit_post) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



In this tutorial will explain and show you how to submit a new post to the `Steem` blockchain using the `commit` class found within the [steem-python](https://github.com/steemit/steem-python) library.

## Intro

The Steem python library has a built-in function to transmit transactions to the blockchain. We are using the `post` method found within the `commit` class in the the library. It should be noted that comments and new post are both treated as `commit.post` operation with the only difference being that a comment/reply has got an additional parameter containing the `parent post/comment`. There are 11 parameters within the `post` method:

1. _title_ - The title of the post
2. _body_ - The body of the post
3. _author_ - The account that you are posting from
4. _permlink_ - A unique adentifier for the
5. _tags_ - Between 1 and 5 key words that defines the post
6. _reply_idendifier_ - Identifier of the parent post(used for comments)
7. _json_metadata_ - JSON meta objec that can be attached to the post
8. _comment_options_ - JSON options object that can be attached to the post to specify additional options like 'max_payouts', 'allow_votes', etc.
9. _community_ - Name of the community you are posting into
10. _beneficiaries_ - A list of beneficiaries for posting reward distribution.
11. _self_vote_ - Upvote the post as author right after posting

We will only be using the first 5 parameters as these are the only ones required to create a basic post. If you want to explore the other parameters further you can find more information [HERE](http://steem.readthedocs.io/en/latest/core.html).

## Steps

1.  [**App setup**](#setup) - Library install and import. Connection to Steem node
2.  [**Variable input and format**](#input) - Input and creation of varialbes
3.  [**Post submission and result**](#submit) - Committing of transaction to the blockchain

#### 1. App setup <a name="setup"></a>

In this tutorial we use 4 packages:

- `random` and `string` - used to create a random string used for the `permlink`
- `steem` - steem-python library and interaction with Blockchain
- `steembase` - used to connect to the testnet

We import the libraries, connect to the `testnet` and initialize the Steem class.

```python
import random
import string
import steembase
import steem

steembase.chains.known_chains['STEEM'] = {
    'chain_id': '79276aea5d4877d9a25892eaa01b0adf019d3e5cb12a97478df3298ccdd01673',
    'prefix': 'STX', 'steem_symbol': 'STEEM', 'sbd_symbol': 'SBD', 'vests_symbol': 'VESTS'
}

#connect node and private posting key
client = steem.Steem(nodes=['https://testnet.steem.vc'], keys=['5JEZ1EiUjFKfsKP32b15Y7jybjvHQPhnvCYZ9BW62H1LDUnMvHz'])
```

Because this tutorial alters the blockchain we have to connect to the testnet. We also require the `private posting key` of the contributing author in order to commit the post which is why it is specified along with the `testnet` node. We have supplied a test account, `cdemo` to use with this tutorial.

#### 2. Variable input and format<a name="input"></a>

The first three variables are captured via a simple string input while the `tags` variable is captured in the form of an array.

```python
#capture variables
author = input('Username: ')
title = input('Post Title: ')
body = input('Post Body: ')

#capture list of tags and separate by " "
taglimit = 2 #number of tags 1 - 5
taglist = []
for i in range(1, taglimit+1):
	print(i)
	tag = input(' Tag : ')
	taglist.append(tag)
```

The `tags` parameter needs to be in the form of a single string with the words split by an empty space, so we add a line to prepare that variable. We also use a random generator to create a new `permlink` for the post being created

```python
" ".join(taglist) #create string joined with empty spaces

#random generator to create post permlink
permlink = ''.join(random.choices(string.digits, k=10))
```

The random generator is limited to 10 characters in this case but the permlink can be up to 256 bytes. If the permlink value is left empty then it auto creates a permlink based on the title of the post. The permlink is unique to the author only which means that multiple authors can have the same title for the thier post.

#### 3. Post submission and result<a name="submit"></a>

The last step is to transmit the post through to the blockchain. This is done `post` method within the `commit` class. All the defined parameters are submitted with the function. As stated earlier in the tutorial, there are quite a few parameters for this function but for a basic post these 5 are the most important.

```python
client.commit.post(title=title, body=body, author=author, tags=taglist, permlink=permlink)

print("Post created successfully")
```

A simple confirmation is printed on the screen if the post is committed successfully.

You can also check on the [testportal](http://condenser.steem.vc/blog/@cdemo) for the post.

### To Run the tutorial

1.  [review dev requirements](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/00_getting_started#dev-requirements)
1.  clone this repo
2.  `cd tutorials/10_submit_post`
3.  `pip install -r requirements.txt`
4.  `python index.py`
5.  After a few moments, you should see a prompt for input in terminal screen.

---
