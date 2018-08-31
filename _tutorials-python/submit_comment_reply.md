---
title: 'PY: Submit Comment Reply'
position: 14
description: 'How to submit a comment on a post to the Steem blockchain.'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Submit Comment Reply](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/14_submit_comment_reply) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



This tutorial will explain and show you how to submit a new comment to the `Steem` blockchain using the `commit` class found within the [steem-python](https://github.com/steemit/steem-python) library.

## Intro

The Steem python library has a built-in function to transmit transactions to the blockchain. We are using the `post` method found within the `commit` class in the the library. It should be noted that comments and post are both treated as a `commit.post` operation with the only difference being that a comment/reply has an additional parameter containing the `parent post/comment`. There are 11 parameters within the `post` method:

1. _title_ - The title of the post. This is a required parameter but comments don't have a title so the parameter is assigned an empty string value
1. _body_ - The body of the post
1. _author_ - The account that you are posting from
1. _permlink_ - A unique adentifier for the
1. _tags_ - Between 1 and 5 key words that defines the post
1. _reply_idendifier_ - Identifier of the parent post(used for comments)
1. _json_metadata_ - JSON meta objec that can be attached to the post
1. _comment_options_ - JSON options object that can be attached to the post to specify additional options like 'max_payouts', 'allow_votes', etc.
1. _community_ - Name of the community you are posting into
1. _beneficiaries_ - A list of beneficiaries for posting reward distribution.
1. _self_vote_ - Upvote the post as author right after posting

We will only be using the parameters titel, body, author, permlink and reply_identifier as they are all that is required for a basic comment operation. If you want to explore the other parameters further you can find more information [HERE](http://steem.readthedocs.io/en/latest/core.html).

A comment made on a post is defined as a `root comment`. You can also comment on someone elses (or your own) comment, in which case the `parent` parameters would be that of the comment, and not the original post.

## Steps

1.  [**App setup**](#setup) - Library install and import. Connection to Steem node
1.  [**Variable input and format**](#input) - Input and creation of varialbes
1.	[**Initialize steem class**](#steem) - Initialize the steem class with the relevant node and private key
1.  [**Post submission and result**](#submit) - Committing of transaction to the blockchain

#### 1. App setup <a name="setup"></a>

In this tutorial we use 4 packages:

- `random` and `string` - used to create a random string used for the `permlink`
- `steem` - steem-python library and interaction with Blockchain
- `steembase` - used to connect to the testnet

We import the libraries and connect to the `testnet`.

```python
import random
import string
import steembase
import steem

steembase.chains.known_chains['STEEM'] = {
    'chain_id': '79276aea5d4877d9a25892eaa01b0adf019d3e5cb12a97478df3298ccdd01673',
    'prefix': 'STX', 'steem_symbol': 'STEEM', 'sbd_symbol': 'SBD', 'vests_symbol': 'VESTS'
}
```

Because this tutorial alters the blockchain we have to connect to the testnet. There is a demo account available for use, `cdemo` with private posting key `5JEZ1EiUjFKfsKP32b15Y7jybjvHQPhnvCYZ9BW62H1LDUnMvHz`. You can also create your own demo account by following the instructions on the [TESTNET](https://testnet.steem.vc/) site.

#### 2. Variable input and format<a name="input"></a>

The variables are captured via a simple string input and allocated as seen below. The `wif` variable is the private posting key of the user making the comment. This key is required to commit the post to the blockchain.

```python
#capture variables
parentAuthor = input('Parent author: ')
parentPermlink = input('Parent permlink: ')
author = input('Username: ')
wif = input('Private posting key: ')
body = input('Comment Body: ')
```

We join the two `parent` values and assign it to the `reply_identifier` parameter. We also use a random generator to create a new `permlink` for the post being created

```python
#combining parent values to create reply identifier
reply_identifier = '/'.join([parentAuthor,parentPermlink])

#random generator to create post permlink
permlink = ''.join(random.choices(string.digits, k=10))
```

The random generator is limited to 10 characters in this case but the permlink can be up to 256 bytes. If the permlink value is left empty then it auto creates a permlink based on the title of the post. The permlink is unique to the author only which means that multiple authors can have the same title for thier post.

#### 3. Initialize steem class<a name="steem"></a>

We initialize the steem class by connecting to the specific `testnet` node. We also require the `private posting key` of the contributing author in order to commit the post which is also specified during this operation.

```python
#connect node and private posting key
client = steem.Steem(nodes=['https://testnet.steem.vc'], keys=[wif])
```

#### 4. Post submission and result<a name="submit"></a>

The last step is to transmit the post through to the blockchain. This is done with the `post` method within the `commit` class. All the defined parameters are submitted with the function. As stated earlier in the tutorial, there are quite a few parameters for this function but for a basic comment these 5 are all that's required.

```python
#commit post to blockchain
client.commit.post(title='', body=body, author=author, permlink=permlink, reply_identifier=reply_identifier)

print("Comment created successfully")
print(permlink)
```

A simple confirmation is printed on the screen if the comment is committed successfully. We also print the `permlink` for the comment on screen. This is purely for convenience to make it easier to retrieve the permlink if a new author or the same author would like to another comment on the one just made.

You can also check on the [testportal](http://condenser.steem.vc/blog/@cdemo) for the comment or for a post to comment on. Alternatively you can create your own post to comment on following the `10_submit_post` tutorial.

### To Run the tutorial

1.  [review dev requirements](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/00_getting_started#dev-requirements)
1.  clone this repo
1.  `cd tutorials/14_submit_comment_reply`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.

---
