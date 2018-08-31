---
title: 'RB: Search Accounts'
position: 15
description: 'Performing a search on account by names starting with a given input.'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Search Accounts](https://github.com/steemit/devportal-tutorials-rb/tree/master/tutorials/15_search_accounts) can be downloaded as part of the [RB tutorials repository](https://github.com/steemit/devportal-tutorials-rb).</span>
<br>



This tutorial will return account names matching the input given, up to a specified limit.

### Sections

1. [Making the api call](#making-the-api-call) - performing the lookup
    1. [Example api call](#example-api-call) - make the call in code
    1. [Example api call using script](#example-api-call-using-script) - using our tutorial script
    1. [Example Output](#example-output) - output from a successful call
1. [To Run](#to-run) - Running the example.

### Making the api call

To request the a list of accounts starting with a particular lookup pattern, we can use the `lookup_accounts` method:

```ruby
api = Radiator::Api.new

api.lookup_accounts(lower_bound_name, limit) do |accounts|
  puts accounts.join(' ')
end
```

Notice, the above example can request up to 1000 accounts as an array.

#### Example api call

If we want to get the accounts starting with "alice" ...

```ruby
api.lookup_accounts("alice", 10) do |content| ...
```

#### Example api call using script

And to do the same with our tutorial script, which has its own default limit of 10:

```bash
ruby search_accounts.rb alice
```

#### Example Output

From the example we get the following output from our script:

```
alice alice-22 alice-is alice-labardo alice-mikhaylova alice-n-chains alice-radster alice-sandra alice-thuigh alice-way
```

### To Run

First, set up your workstation using the steps provided in [Getting Started](https://developers.steem.io/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository):

* `<lower-bound-name>`
* `[limit]` (optional)

```bash
git clone git@github.com:steemit/devportal-tutorials-rb.git
cd devportal-tutorials-rb/tutorials/15_search_accounts
bundle install
ruby search_accounts.rb <lower-bound-name> [limit]
```

---
