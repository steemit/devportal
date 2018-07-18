---
title: 'RB: Search Tags'
position: 16
description: Performing a search for tags
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Search Tags](https://github.com/steemit/devportal-tutorials-rb/tree/master/tutorials/16_search_tags) can be downloaded as part of the [RB tutorials repository](https://github.com/steemit/devportal-tutorials-rb).</span>
<br>



This tutorial will return tags sorted by trending, up to a specified limit.

### Sections

1. [Making the api call](#making-the-api-call) - performing the lookup
    1. [Example api call](#example-api-call) - make the call in code
    1. [Example api call using script](#example-api-call-using-script) - using our tutorial script
    1. [Example Output](#example-output) - output from a successful call
    1. [Tag Fields](#tag-fields) - details of fields returned
1. [To Run](#to-run) - Running the example.

### Making the api call

To request the a list of tags, we can use the `get_trending_tags` method:

```ruby
api = Radiator::Api.new

api.get_trending_tags(nil, 100) do |tags|
  puts tags
end
```

Notice, the above example can request up to 100 tags as an array.

#### Example api call

If we want to get 10 tags starting from the tag named "music" ...

```ruby
api.get_trending_tags("music", 10) do |content| ...
```

#### Example api call using script

And to do the same with our tutorial script, which has its own default limit of 10.  Internally, the api method only allows at most 100 results, so this tutorial will paginate the results to go beyond 100:

```bash
ruby search_tags.rb
```

#### Example Output

From the example we get the following output from our script:

```
tag: <empty>, total_payouts: 57513246.041 SBD, net_votes: 47471936, top_posts: 4523493, comments: 27287924, trending: 100430269400
tag: life, total_payouts: 12563434.550 SBD, net_votes: 10898489, top_posts: 1193059, comments: 1164873, trending: 7440962326
tag: photography, total_payouts: 7529111.644 SBD, net_votes: 8578110, top_posts: 819008, comments: 1498469, trending: 7311205387
tag: kr, total_payouts: 2953387.067 SBD, net_votes: 749380, top_posts: 79842, comments: 2138776, trending: 7009078414
tag: steemit, total_payouts: 8531217.920 SBD, net_votes: 5393375, top_posts: 580400, comments: 1156174, trending: 5471456871
tag: art, total_payouts: 4017591.434 SBD, net_votes: 3577651, top_posts: 330597, comments: 716566, trending: 3302526197
tag: bitcoin, total_payouts: 3556944.650 SBD, net_votes: 2885034, top_posts: 416088, comments: 625529, trending: 3284115413
tag: introduceyourself, total_payouts: 1863437.063 SBD, net_votes: 725570, top_posts: 24891, comments: 986875, trending: 3185017448
tag: spanish, total_payouts: 1221282.258 SBD, net_votes: 2683931, top_posts: 154983, comments: 827033, trending: 3103643123
tag: travel, total_payouts: 3976626.578 SBD, net_votes: 2505962, top_posts: 229401, comments: 622754, trending: 2687292306
```

### Tag fields

Tags in the results of `get_trending_tags` returns the following fields:

* `name` - Name of the tag or empty.
* `total_payouts` - Rewards paid in this tag.
* `net_votes` - Net votes in this tag.
* `top_posts` - Top votes in this tag.
* `comments` - Number of comments in this tag.
* `trending` - Total trending.

### To Run

First, set up your workstation using the steps provided in [Getting Started](https://developers.steem.io/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository):

* `[limit]` (optional)

```bash
git clone git@github.com:steemit/devportal-tutorials-rb.git
cd devportal-tutorials-rb/tutorials/16_search_tags
bundle install
ruby search_tags.rb [limit]
```

---
