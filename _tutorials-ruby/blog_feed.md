---
title: Blog Feed
position: 2
exclude: true
layout: main-script
description: A simple blog feed tutorial using ruby
main_script: tutorials-ruby/blog_feed.rb
main_type: ruby
main_script_anchor: Script
---

This example will output blog details to the terminal for the author specified, limited to five results.

### Script

Create a filed called `blog_feed.rb` and run it:

```bash
ruby blog_feed.rb steemitblog
```

The script parses the creation date, assuming Zulu timezone (AKA UTC).

The output will be the latest five posts/reblogs for the account specified.  If the author is the same as the account specified, it is assumed to be a post by this account.  Otherwise, it is assumed to be a reblog.

It also counts the words in the content body by splitting the text into an array of strings, delimited by whitespace.

Finally, it creates the canonical URL by combining `parent_permlink`, `author`, and `permlink`.

### Example Output

```
2018-03-24 17:30:36 UTC
  Post: Happy 2nd Birthday Steem Blockchain
  By: steemitblog
  Words: 301
  https://steemit.com/steem/@steemitblog/happy-2nd-birthday-steem-blockchain
2018-03-07 20:56:36 UTC
  Post: Join Team Steemit at TokenFest!
  By: steemitblog
  Words: 104
  https://steemit.com/steemit/@steemitblog/join-team-steemit-at-tokenfest
2018-02-27 20:18:36 UTC
  Post: Smart Media Token Development
  By: steemitblog
  Words: 699
  https://steemit.com/smt/@steemitblog/smart-media-token-development
2018-02-25 20:55:24 UTC
  Reblog: I filmed this video of @ned @pkattera and @sneak talking about the SMTs and the future of Steemit
  By: ruwan
  Words: 89
  https://steemit.com/steemit/@ruwan/i-filmed-this-video-of-ned-pkattera-and-sneak-talking-about-the-smts-and-the-future-of-steemit
2018-02-22 17:41:00 UTC
  Post: STEEM 및 SBD가 GOPAX에 상장되었습니다
  By: steemitblog
  Words: 317
  https://steemit.com/gopax/@steemitblog/steem-sbd-gopa
```