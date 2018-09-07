---
title: 'RB: Get Account Replies'
position: 8
description: 'Fetching the replies written to a particular account.'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get Account Replies](https://github.com/steemit/devportal-tutorials-rb/tree/master/tutorials/08_get_account_replies) can be downloaded as part of the [RB tutorials repository](https://github.com/steemit/devportal-tutorials-rb).</span>
<br>



Historically, applications that wanted to retrieve replies written to a particular account would use `get_state`.  But this method has been scheduled for deprecation.  So we'll use a more supported approach in this tutorial using `get_account_history`.

### Sections

1. [Making the api call](#making-the-api-call) - Requesting account history
    1. [Example api call](#example-api-call) - make the call in code
    1. [Example api call using script](#example-api-call-using-script) - using our tutorial script
    1. [Example Output](#example-output) - output from a successful call
1. [Comment Fields](#comment-fields) - Getting more detail than provided by account history.
1. [To Run](#to-run) - Running the example.

### Making the api call

To request the latest replies to a particular author, we can use the `get_account_history` method:

```ruby
api = Radiator::Api.new

api.get_account_history(account_name, -1, 10000) do |history|
  history.each do |index, item|
    type, op = item.op
    
    next unless type == 'comment'
    next if op.parent_author.empty? # skip posts
    next unless op.parent_author == account_name # skip comments by account

    # .
    # ... your code here
    # .
  end
end
```

Notice, the above example request up to 10,000 operations from history, starting from the oldest.  From these results, we iterate on each item in history to locate **a)** type of `comment`, and **b)** `parent_author` that match the `account_name`.

#### Example api call

If we want to get the replies to user @lordvader ...

```ruby
api.get_account_history("lordvader") do |content| ...
```

#### Example api call using script

And to do the same with our tutorial script
```bash
ruby get_account_replies.rb lordvader
```

#### Example Output

From the example we get the following output from our script:

```
.
.
.
Reply by @steemitboard in discussion: "The Empire has sent you a friend request."
	body_length: 677 (99 words)
	replied at: 2018-04-28T04:32:42
	net_votes: 0
	https://steemit.com/@steemitboard/steemitboard-notify-lordvader-20180428t043241000z
Reply by @jedimasteryoda in discussion: "The Empire has sent you a friend request."
	body_length: 65 (11 words)
	replied at: 2018-06-07T18:47:54
	net_votes: 0
	https://steemit.com/@jedimasteryoda/re-lordvader-the-empire-has-sent-you-a-friend-request-20180607t184754944z
Reply by @koinbot in discussion: "The Empire has sent you a friend request."
	body_length: 15 (2 words)
	replied at: 2018-06-23T07:58:51
	net_votes: 0
	https://steemit.com/@koinbot/re-lordvader-the-empire-has-sent-you-a-friend-request-20180623t075851464z
```

### Comment fields

Replies in the results of `get_account_history` will only return the following fields:

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
cd devportal-tutorials-rb/tutorials/08_get_account_replies
bundle install
ruby get_account_replies.rb <account-name>
```

---
