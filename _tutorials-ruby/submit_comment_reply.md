---
title: 'RB: Submit Comment Reply'
position: 11
description: '_By the end of this tutorial you should know how to prepare comments for Steem and then submit using Radiator._'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Submit Comment Reply](https://github.com/steemit/devportal-tutorials-rb/tree/master/tutorials/11_submit_comment_reply) can be downloaded as part of the [RB tutorials repository](https://github.com/steemit/devportal-tutorials-rb).</span>
<br>



### Intro

This example will broadcast a reply to the blockchain using the values provided.  To create a post in `ruby`, we will use a `Radiator::Transaction` containing a `comment` operation, which is how all content is stored internally.

A reply is differentiated from a post by whether or not a `parent_author` exists. When there is no `parent_author`, then it's a post, otherwise it's a comment (like in this example).

### Script

You should change `wif` to the posting key that matches your `author`.  This script will pass along the values as a [`comment` operation](https://developers.steem.io/apidefinitions/broadcast-ops#broadcast_ops_comment):

* `author` - Account name of the author currently replying.
* `permlink` - Value unique to the author 
* `parent_author` - The name of the author of the being replied to, in the case of a reply like this example.
* `parent_permlink` - The permlink of the content being replied to, in the case of a reply like this example.
* `title` - Typically empty.
* `body` - The actual content of the post.
* `json_metadata` - JSON containing the `parent_permlink` of the root post as a tags array.

### To Run

First, set up your workstation using the steps provided in [Getting Started](https://developers.steem.io/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository):

```bash
git clone git@github.com:steemit/devportal-tutorials-rb.git
cd devportal-tutorials-rb/tutorials/11_submit_comment_reply
bundle install
ruby submit_comment_reply.rb
```

### Example Output

```json
{
  "jsonrpc": "2.0",
  "result": {
    "id": "3fef14cac921e9baa7b31e43245e5380f3fb4332",
    "block_num": 23355115,
    "trx_num": 13,
    "expired": false
  },
  "id": 3
}
```

The response we get after broadcasting the transaction gives us the transaction id ([`3fef14c...`](https://steemd.com/tx/3fef14cac921e9baa7b31e43245e5380f3fb4332)), block number ([`22867626`](https://steemd.com/b/23355115)), and the transaction number of that block (`13`).

#### Error Handling

We're checking the result for `error` in case the remote node has an issue to raise.  Normally, it will be `nil`, but if it's populated, output `error.message` and exit.

---
