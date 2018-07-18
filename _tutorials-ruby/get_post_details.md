---
title: 'RB: Get Post Details'
position: 5
description: Understand and use the most common fields of the requested content
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get Post Details](https://github.com/steemit/devportal-tutorials-rb/tree/master/tutorials/05_get_post_details) can be downloaded as part of the [RB tutorials repository](https://github.com/steemit/devportal-tutorials-rb).</span>
<br>



### Intro

This tutorial fetches the contents of a single post and explains all data related to that post.

We will also describe the most commonly used fields from the response object.

### Sections

1. [Making the api call](#making-the-api-call) - Use steem-rb to a specific post
    1. [Example api call](#example-api-call) - make the call in code
    1. [Example api call using script](#example-api-call-using-script) - using our tutorial script
    1. [Example Output](#example-output) - output from a successful call
1. [Post Fields](#post-fields) - General use of the method to determine ...
    1. [`parent_author`](#parent_author) - if the content is a root post or reply
    1. [`last_update` and `created`](#last_update-and-created) - if the content has been modified
    1. [`cashout_time`](#cashout_time) - if the content has reached payout
    1. [`beneficiaries`](#beneficiaries) - reward routes other accounts
    1. [`active_votes`](#active_votes) - all votes applied
    1. [`json_metadata`](#json_metadata) - things like `tags` and `app`
2. [Script](#script) - Delving into the example script.
3. [To Run](#to-run) - Running the example.

### Making the api call

To request a specific post we use the `get_content` method:

```ruby
api = Radiator::Api.new

api.get_content(author, permlink) do |content|
  # .
  # ... your code here
  # .
end
```

#### Example api call
If we want to get the post "announcing-the-steem-developer-portal" by user @steemitdev
```ruby
api.get_content("steemitdev", "announcing-the-steem-developer-portal") do |content| ...
```

#### Example api call using script
And to do the same with our tutorial script
```bash
ruby get_post_details.rb https://steemit.com/steemdev/@steemitdev/announcing-the-steem-developer-portal
```

#### Example Output

From the example we get the following output from our script

```
Post by steemitdev
	title: Announcing the Steem Developer Portal!
	permlink: announcing-the-steem-developer-portal
	category: steemdev
	body_length: 2342 (381 words)
	posted at: 2017-10-30T16:34:27, updated at: 2017-10-30T16:34:27, active at: 2018-04-11T10:34:00
	children: 66
	net_rshares: 0
	vote_rshares: 0
	payout:
		max_accepted_payout: 0.000 SBD
		percent_steem_dollars: 100.00 %
		payout at: 2017-11-06T16:34:27 (235.2 days ago)
		author_rewards: 0.000 SBD
		curator_payout_value: 0.000 SBD
		total_payout_value: 0.000 SBD
	promoted: 0.000 SBD
	total_vote_weight: 0
	reward_weight: 100.00 %
	net_votes: 181, upvotes: 234, downvotes: 1, unvotes: 0, total: 235, top voter: thejohalfiles
	allow_replies: true
	allow_votes: true
	allow_curation_rewards: true
	author_reputation: 14487360227924
	tags: steemdev, steem, dev
	app: steemit/0.1
```



### Post fields

Most console applications that use the `get_content` method are probably looking for the `body` field.  But there are many other fields to look at.  Let's break them down by use:

#### `parent_author`

In our script (`get_post_details.rb`), we use the ruby statement:

```ruby
content.parent_author.empty?
```

With the above idiom, your application can determine if the content is a root post or reply.  If it's empty, then you're working with a root post, otherwise, it's a reply.

Once you know you're dealing with a reply, other fields can be useful for additional details.  For instance, `root_author`, `root_permlink`, and `root_title` can be used to figure out what the original post details are, even if the reply is deeply nested.

#### `last_update` and `created`

In our script, we use the ruby statement:

```ruby
content.last_update == content.created
```

With the above idiom, your application can determine if the content has been modified since it was originally posted.  If they are the same, then there has been no modification.

#### `cashout_time`

In our script, we use the ruby statement:

```ruby
(cashout = Time.parse(content.cashout_time + 'Z') - Time.now.utc) > 0
```

With the above idiom, you can use `cashout_time` to determine if the content has reached payout.  If `cashout_time` is in the future, the content has not been paid yet.  You can determine the possible future payout by inspecting `pending_payout_value`.

You will note that we must parse the string found in `content.cashout_time` by appending `Z` (Zulu Time, aka UTC) in order for `Time.parse` to get the right timezone.

Even before payout, you can determine what the `max_accepted_payout` is.  Most often, this is set to one of two values by the author:

* `1000000.000 SBD` - Accepted Payout
* `0.000 SBD` - Declined Payout

In addition to `max_accepted_payout`, the author may specify how much of the author reward should be in STEEM Power or liquid rewards.  The most common settings are:

* `10000` - Maximum Liquid Reward
* `0` - STEEM Power Only

Once the payout time has arrived, it's possible to determine the split between author and curation by inspecting at `author_rewards` and `curator_payout_value`.

#### `beneficiaries`

In our script, we use the ruby statement:

```ruby
content.beneficiaries.any?
```

Some content will have a `beneficiaries` array.  This is used to determine reward routes any account, up to eight.  Payouts are in STEEM Power and are expressed as a reward percentage of the author reward.

To display a list of who the beneficiaries are, use the following ruby code, as seen in the example:

```ruby
content.beneficiaries.each do |beneficiary|
  puts "\t\t#{beneficiary.account}: #{'%.2f %' % (beneficiary.weight / 100.0)}"
end
```

Note, if you just want an array of beneficiary account names, this will work in a pinch:

```ruby
accounts = content.beneficiaries.map do |beneficiary|
  beneficiary.account
end
```

#### `active_votes`

In our script, we use the ruby statements:

```ruby
votes = content.active_votes
upvotes = votes.select { |v| v.percent > 0 }.size
downvotes = votes.select { |v| v.percent < 0 }.size
unvotes = votes.select { |v| v.percent == 0 }.size
top_voter = votes.sort_by { |v| v.rshares.to_i }.last.voter
```

The above idiom splits all vote types and identifies the top voter.  This is because the `active_votes` field is an array that shows all votes applied to the content, including upvotes, downvotes, and unvotes (where a vote previously cast is revoked).

#### `json_metadata`

In our script, we use the ruby statements:

```ruby
metadata = JSON[content.json_metadata || '{}'] rescue {}
tags = metadata['tags'] || []
app = metadata['app']
```

As you can see from the above example, `json_metadata` starts out as a string of JSON that can be parsed to determine things like `tags` and `app`.  Other data may be present, depending on the application that created the content.

Note, we're using `rescue` in case the `json_metadata` string contains invalid JSON because there is no validation performed on this field by the blockchain when content is broadcasted.


### To Run

First, set up your workstation using the steps provided in [Getting Started](https://developers.steem.io/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository):

*`<content-url>` 

```bash
git clone git@github.com:steemit/devportal-tutorials-rb.git
cd devportal-tutorials-rb/tutorials/05_get_post_details
bundle install
ruby get_post_details.rb <content-url>
```


---
