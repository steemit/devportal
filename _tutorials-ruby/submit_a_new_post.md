---
title: Submit a New Post
position: 5
exclude: true
layout: main-script
description: Broadcast a new top level post.
main_script: tutorials-ruby/submit_a_new_post.rb
main_type: ruby
main_script_anchor: Script
---

### Intro

This example will broadcast a new post to the blockchain using the values provided.

### Script

Create a filed called `submit_a_new_post.rb`.

You should change `wif` to the posting key that matches your `author`.  This script will pass along the values as a [`comment` operation](/apidefinitions/broadcast-ops#broadcast_ops_comment):

* `author` - Account name of the author currently posting.
* `permlink` - Value unique to the author 
* `parent_author` - An empty string, in the case of a root post like this example.
* `parent_permlink` - The first tag, in the case of a root post like this example.
* `title` - Human readable title.
* `body` - The actual content of the post.
* `json_metadata` - JSON containing all of the tags.

#### Error Handling

We're checking the result for `error` in case the remote node has an issue to raise.  Normally, it will be `nil`, but if it's populated, output `error.message` and exit.

### To Run

First, set up your workstation using the steps provided in [Getting Started](/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository):

```bash
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
