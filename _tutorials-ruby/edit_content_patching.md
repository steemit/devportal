---
title: How to edit a Post
position: 5
exclude: true
layout: full-row
description: Patching changes to a post on Steem.
---

This tutorial will show a technique for efficiently editing a post by only broadcasting changes to the post body.

### Script

Create a filed called `edit_content_patching.rb`.

This script will take an existing post and append a new line by broadcasting a `comment` operation containing a `diff` instruction.  This instruction will tell the blockchain to append new content to the end of the `body` of the original comment.

Because this is a live example, we set `broadcast` to `false` so that it only runs if you modify the example and set `broadcast` to `true`.

### To Run

First, set up your workstation using the steps provided in [Getting Started](/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository):

As stated earlier, you will need to change `broadcast` to `true`.  You can also set other values to test this script on other post:

* `wif` - The posting key of the author.
* `author` - Name of the account that wrote the post we're modifying.
* `title` - Title of the post.
* `permlink` - Leave this if the `permlink` is derived from the title or set it to the original `permlink` if you want to modify the title independently from the `permlink`.

Then run it:

```bash
ruby edit_content_patching.rb
```

### Example Output

```
Changes:
@@ -26,8 +26,26 @@
  edited)
+%0AAppended content.
{
  "jsonrpc": "2.0",
  "result": {
    "id": "f327acc1c51d907a9ba9bfac70e6fc9e99ab2865",
    "block_num": 23035803,
    "trx_num": 0,
    "expired": false
  },
  "id": 1
}
```
