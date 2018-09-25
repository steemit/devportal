---
title: 'RB: Stream Blockchain Transactions'
position: 13
description: "*How to stream transactions and operations from Steem blockchain.*"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Stream Blockchain Transactions](https://github.com/steemit/devportal-tutorials-rb/tree/master/tutorials/13_stream_blockchain_transactions) can be downloaded as part of the [RB tutorials repository](https://github.com/steemit/devportal-tutorials-rb).</span>
<br>



To respond to live activity on the blockchain, a common approach is to make a request for the current block number, access all of the information in that block, and repeat.  Many API clients have dedicated tools for simplifying this process.  In Radiator, this tool is part of the `Radiator::Stream` class.  In addition, Radiator will allow you to specify exactly what type of operation you're interested in.

### Sections

1. [Streaming Transactions](#streaming-transactions)
1. [Streaming Operations](#streaming-operations)
1. [To Run](#to-run) - Running the example.

### Streaming Transactions

In the example script, we can stream transactions with the following arguments:

```bash
ruby stream_blockchain_transactions.rb head transactions
```

This will instruct the script to follow transactions at head `block_num` instead of irreversible.

See: [`head_block_number`](https://developers.steem.io/tutorials-recipes/understanding-dynamic-global-properties#head_block_number) vs. [`last_irreversible_block_num`](https://developers.steem.io/tutorials-recipes/understanding-dynamic-global-properties#last_irreversible_block_num)

This is done by using the following ruby:

```ruby
stream.transactions(*args) do |trx|
  puts JSON.pretty_generate trx
end
```

The `args` variable contains the `start` (`block_num` to start from) and `mode` (`head` or `irreversible`).

#### Streaming Operations

In the example script, we can also pass the following arguments:

```bash
ruby stream_blockchain_transactions.rb head ops comment
```

This will instruct the script to follow the blockchain at head `block_num` instead of irreversible.  It will stream operations, with the type of `comment`.

The script will allow multiple operation types:

```bash
ruby stream_blockchain_transactions.rb head ops comment vote
```

Virtual operations are also allowed, but make sure to pass `irreversible` instead of `head`:

```bash
ruby stream_blockchain_transactions.rb irreversible ops producer_reward author_reward
```

Or, if you pass no operation types, the script will stream all types:

```bash
ruby stream_blockchain_transactions.rb head ops
```

This is done by using the following ruby:

```ruby
stream.operations(type, *args) do |op|
  puts op.to_json
end
```

The `type` variable can be `nil` or the type of ops we're looking for whereas `args` contains the `start` (`block_num` to start from) and `mode` (`head` or `irreversible`).

### To Run

First, set up your workstation using the steps provided in [Getting Started](https://developers.steem.io/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository):

```bash
git clone git@github.com:steemit/devportal-tutorials-rb.git
cd devportal-tutorials-rb/tutorials/13_stream_blockchain_transactions
bundle install
ruby stream_blockchain_transactions.rb
```

### Example Output

```json
{"voter":"piggypet","author":"tanama","permlink":"daily-2018-9-12","weight":10000}
{"voter":"votes4minnows","author":"askquestion","permlink":"latest-bitcoin-price-and-news-update-13-09-2018","weight":250}
{"voter":"vncedora2018","author":"adncabrera","permlink":"nicomedescuentalacadadelreytanospoema-98jxnjsjzu","weight":10000}
{"voter":"baimatjeh81","author":"albertvhons","permlink":"promoting-steemit-post-via-proof-of-participation-pop","weight":10000}
{"voter":"steemulator","author":"bonanza-kreep","permlink":"communicate-and-travel-with-alfa-enzo-new-social-network","weight":10000}
{"voter":"kernigeetrueset","author":"haejin","permlink":"vitamin-shoppe-vsi-analysis","weight":10000}
{"voter":"borrowedearth","author":"rijalmahyud","permlink":"this-is-my-job","weight":10000}
{"voter":"renatdag","author":"algarion","permlink":"cards-3-1536663927","weight":10000}
{"voter":"elieserurabno","author":"cathyhaack","permlink":"my-introduction-hello-word-of-steemit","weight":10000}
{"voter":"jmotip","author":"glennolua","permlink":"btc-chart-review-sept-12-20-00-pst","weight":10000}
{"voter":"bishalacharya","author":"barber78","permlink":"beautiful-cloudformations","weight":10000}
{"voter":"ivan174","author":"securixio","permlink":"cloud-mining-is-no-longer-profitable","weight":10000}
{"voter":"admiralbot","author":"homsys","permlink":"rare-photo-picture-698-105","weight":-10000}
```

---
