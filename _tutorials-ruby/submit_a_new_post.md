---
title: Submit a New Post
position: 10
exclude: true
layout: full-row
description: Broadcast a new top level post.
---

This example will broadcast a new post to the blockchain using the values provided.  To create a post in `ruby`, we will use a `Radiator::Transaction` containing a `comment` operation, which is how all content is stored internally.

A post is differentiated from a comment by whether or not a `parent_author` exists. When there is no `parent_author`, then it's a post, otherwise it's a comment.

### Script

You should change `wif` to the posting key that matches your `author`.  This script will pass along the values as a [`comment` operation](/apidefinitions/broadcast-ops#broadcast_ops_comment):

* `author` - Account name of the author currently posting.
* `permlink` - Value unique to the author 
* `parent_author` - An empty string, in the case of a root post like this example.
* `parent_permlink` - The first tag, in the case of a root post like this example.
* `title` - Human readable title.
* `body` - The actual content of the post.
* `json_metadata` - JSON containing all of the tags.

### To Run

First, set up your workstation using the steps provided in [Getting Started](https://developers.steem.io/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository):

```bash
git clone git@github.com:steemit/devportal-tutorials-rb.git
cd devportal-tutorials-rb/tutorials/10_submit_post
bundle install
ruby submit_a_new_post.rb
```

### Example Output

```json
{
  "jsonrpc": "2.0",
  "result": {
    "id": "768f7f64cee94413da0017ef79f592bb4da86baf",
    "block_num": 22867626,
    "trx_num": 43,
    "expired": false
  },
  "id": 1
}
```

The response we get after broadcasting the transaction gives us the transaction id ([`768f7f6...`](https://steemd.com/tx/768f7f64cee94413da0017ef79f592bb4da86baf)), block number ([`22867626`](https://steemd.com/b/22867626)), and the transaction number of that block (`43`).

#### Error Handling

We're checking the result for `error` in case the remote node has an issue to raise.  Normally, it will be `nil`, but if it's populated, output `error.message` and exit.
