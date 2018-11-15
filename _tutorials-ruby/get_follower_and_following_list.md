---
title: 'RB: Get Follower And Following List'
position: 19
description: "_How to create a list of followers and accounts that you are following._"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get Follower And Following List](https://github.com/steemit/devportal-tutorials-rb/tree/master/tutorials/19_get_follower_and_following_list) can be downloaded as part of the [RB tutorials repository](https://github.com/steemit/devportal-tutorials-rb).</span>
<br>



This tutorial will take you through the process of requesting either the `follower` or `following` list for an account on the blockchain.

## Intro

In `radiator`, we can request follow results using `condenser_api.get_following` or `condenser_api.get_follows` methods.  These methods take the following arguments:

* `account` - The account for which the follower/following process will be executed.
* `start` - Where in the list to begin getting results.
* `type` - We are going to pass `blog` for all requests to only request follow results (as opposed to mute results, which takes the value: `ignore`).
* `limit` - The number of lines to be returned by the query (`limit`, maximum 1000 per call)

## Steps

1.  [**Configure connection**](#connection) Configuration of `radiator` to communicate with the Steem blockchain
2.  [**Input variables**](#input) Collecting the required inputs via command line arguments
3.  [**Get followers/following**](#query) Get the followers or accounts being followed
4.  [**Display**](#display) Return the array of results to the console

#### 1. Configure connection<a name="connection"></a>

In the first few lines we initialize the configured library and packages (libraries are described in `Gemfile`):

```ruby
require 'rubygems'
require 'bundler/setup'

Bundler.require

api = Radiator::Api.new
```

Above, we have `radiator` pointing to the production network.  To specify a different full node, e.g.:

```ruby
api = Radiator::Api.new(url: 'https://testnet.steemitdev.com')
```

#### 2. Input variables<a name="input"></a>

Capture the arguments from the command line.

```ruby
account = ARGV[0]
type = ARGV[1] || 'following'
limit = (ARGV[2] || '-1').to_i
```

#### 3. Get followers/following<a name="query"></a>

Depending on the arguments passed, we call the corresponding method and the element name of what we are requesting:

```ruby
method = "get_#{type}"
elem = type.sub(/s/, '').to_sym
```

The name of the `elem` value stored corresponds with the result elements we're interested in.  For method calls on `get_following`, we want the `following` elements.  For method calls on `get_followers`, we want `follower` elements.

#### 4. Display<a name="display"></a>

Iterate multiple calls to capture all of the results.

```ruby
until count >= result.size
  count = result.size
  response = api.send(method, account, result.last, what, [limit, 100].max)
  abort response.error.message if !!response.error
  result += response.result.map(&elem)
  result = result.uniq
end
```

### To Run

First, set up your workstation using the steps provided in [Getting Started](https://developers.steem.io/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository):

```bash
git clone git@github.com:steemit/devportal-tutorials-rb.git
cd devportal-tutorials-rb/tutorials/19_get_follower_and_following_list
bundle install
ruby get_follow.rb
```


---
