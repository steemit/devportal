---
title:  Voter List
position: 3
exclude: true
layout: main-script
description: Shows active vote totals
main_script: tutorials-ruby/voter_list.rb
main_type: ruby
main_script_anchor: Script
---

This example will output the active vote totals for the post/comment passed as an argument to the script.

### Script

Create a filed called `voter_list.rb` and run it:

```bash
ruby voter_list.rb https://steemit.com/steemdev/@steemitdev/announcing-the-steem-developer-portal
```

First, we ask the blockchain for the active votes on a post or comment.  Then, we count the `upvotes`, `downvotes`, and `unvotes` (which are votes that have been removed after being cast in a previous transaction).

Then, we sort the votes by `rshares` to find the top voter.

### Example Output

```
Upvotes: 231
Downvotes: 1
Unvotes: 0
Total: 232
Top Voter: thejohalfiles
```
