---
title: Get Posts by Category
position: 4
exclude: true
layout: main-script
description: Get post list from different category (trending, hot, active, etc.)
main_script: tutorials-ruby/get_posts_by_category.rb
main_type: ruby
main_script_anchor: Script
---

### Intro

This example will output posts depending on which category is provided as the arguments.

### Script

Create a filed called `get_posts_by_category.rb`.

This script will pick a method to call based on the arguments passed.  The expected categories are:

* trending
* hot
* active
* created
* votes
* promoted
* children

We will base the name of the API method to execute on the provided argument.  Once we know which method to execute, we can build the query options.  The defaults for this script is `limit: 10` and `tag: ''`.

For each post we retrieve, we are going to build up a summary to display the interesting fields.  In this case, we're interested in:

* Creation Timestamp
* Title
* Author
* Net Votes
* Number of replies
* If it's promoted
* Number of words in the body
* Canonical URL

#### Error Handling

We're checking the result for `error` in case the remote node has an issue to raise.  Normally, it will be `nil`, but if it's populated, output `error.message` and exit.

### To Run

First, set up your workstation using the steps provided in [Getting Started](/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository):

```bash
ruby get_posts_by_category.rb trending 1 steem
```

### Example Output

```
2018-05-24 06:38:33 UTC
  Post: New Phone App For Steemit - Wow!
  By: happymoneyman
  Votes: 1087
  Replies: 332
  Promoted: 0.001 SBD
  Words: 190
  https://steemit.com/steemit/@happymoneyman/new-phone-app-for-steemit-wow
```
