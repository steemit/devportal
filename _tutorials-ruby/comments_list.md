---
title: Comments List
position: 4
exclude: true
layout: main-script
description: Shows replies to content
main_script: tutorials-ruby/comments_list.rb
main_type: ruby
main_script_anchor: Script
---

This example will output the reply details and totals for the post/comment passed as an argument to the script.

### Script

Create a filed called `comments_list.rb` and run it:

```bash
ruby comments_list.rb https://steemit.com/steem/@steemitblog/dev-portal-update-new-steem-developer-resources
```

First, we ask the blockchain for the replies on a post or comment.  Then, we grab the authors of those replies and list them, followed by the total comments count.

### Example Output

```
Replies by:
	shahabshah
	mumin007
	bigblueleadsled
	reseller
	latikasha
	dannywill
	steemitag
	sequentialvibe
	xplosive
	whatsup
	evolved08gsr
	steevc
	mightymicke
	marc0o
	akintunde
	oliverlai
	zufrizal
	bitcointravel
	vsf
	badribireuen
Total replies: 20
```
