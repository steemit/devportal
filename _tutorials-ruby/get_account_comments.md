---
title: 'RB: Get Account Comments'
position: 9
description: 'Fetching the comments written by a particular account.'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get Account Comments](https://github.com/steemit/devportal-tutorials-rb/tree/master/tutorials/09_get_account_comments) can be downloaded as part of the [RB tutorials repository](https://github.com/steemit/devportal-tutorials-rb).</span>
<br>



Historically, applications that wanted to retrieve comments written by a particular account would use `get_state`.  But this method has been scheduled for deprecation.  So we'll use a more supported approach in this tutorial using `get_account_history`.

### Sections

1. [Making the api call](#making-the-api-call) - Requesting account history
    1. [Example api call](#example-api-call) - make the call in code
    1. [Example api call using script](#example-api-call-using-script) - using our tutorial script
    1. [Example Output](#example-output) - output from a successful call
1. [Comment Fields](#comment-fields) - Getting more detail than provided by account history.
1. [To Run](#to-run) - Running the example.

### Making the api call

To request the latest comments by a particular author, we can use the `get_account_history` method:

```ruby
api = Radiator::Api.new

api.get_account_history(account_name, -1, 10000) do |history|
  history.each do |index, item|
    type, op = item.op
    
    next unless type == 'comment'
    next if op.parent_author.empty? # skip posts
    next if op.parent_author == account_name # skip replies to account

    # .
    # ... your code here
    # .
  end
end
```

Notice, the above example request up to 10,000 operations from history, starting from the oldest.  From these results, we iterate on each item in history to locate **a)** type of `comment`, and **b)** `parent_author` that do not match the `account_name`.

#### Example api call

If we want to get the comments by user @lordvader ...

```ruby
api.get_account_history("lordvader") do |content| ...
```

#### Example api call using script

And to do the same with our tutorial script
```bash
ruby get_account_comments.rb lordvader
```

#### Example Output

From the example we get the following output from our script:

```
.
.
.
Reply to @saarliconvalley in discussion: "The Empire has sent you a friend request."
	body_length: 33 (7 words)
	replied at: 2018-03-27T16:02:45
	net_votes: 0
	https://steemit.com/@lordvader/re-saarliconvalley-re-lordvader-2018327t16025594z-20180327t160243538z
Reply to @teenovision in discussion: "The Empire has sent you a friend request."
	body_length: 90 (16 words)
	replied at: 2018-03-27T15:53:39, updated at: 2018-03-30T17:25:18, active at: 2018-03-30T17:25:18
	net_votes: 0
	https://steemit.com/@lordvader/re-teenovision-re-lordvader-the-empire-has-sent-you-a-friend-request-20180327t155339532z
Reply to @gtg in discussion: "gtg witness log"
	body_length: 130 (25 words)
	replied at: 2018-04-06T04:29:00
	net_votes: 2
	https://steemit.com/@lordvader/re-gtg-ffdhu-gtg-witness-log-20180406t042906872z
```

### Comment fields

Comments in the results of `get_account_history` will only return the following fields:

* `parent_author`
* `parent_permlink`
* `author`
* `permlink`
* `title`
* `body`
* `json_metadata`

In our example script, we want more detail than this, so for every `comment`, we call `get_content` to retrieve more detail.  For a full explanation of the results provided by `get_content`, please refer to the tutorial: [Get Post Details](https://github.com/steemit/devportal-tutorials-rb/tree/master/tutorials/05_get_post_details)

### To Run

First, set up your workstation using the steps provided in [Getting Started](https://developers.steem.io/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository):

* `<account-name>`

```bash
git clone git@github.com:steemit/devportal-tutorials-rb.git
cd devportal-tutorials-rb/tutorials/09_get_account_comments
bundle install
ruby get_account_comments.rb <account-name>
```

---
