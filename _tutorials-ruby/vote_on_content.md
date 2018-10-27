---
title: 'RB: Vote On Content'
position: 17
description: "To vote for a post (or reply), we can use a vote operation and provide the voting weight (the percentage of one vote being cast)."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Vote On Content](https://github.com/steemit/devportal-tutorials-rb/tree/master/tutorials/17_vote_on_content) can be downloaded as part of the [RB tutorials repository](https://github.com/steemit/devportal-tutorials-rb).</span>
<br>



### Sections

1. [Making the api call](#making-the-api-call) - broadcasting the operation
    1. [Example api call](#example-api-call) - make the call in code
    1. [Example api call using script](#example-api-call-using-script) - using our tutorial script
    1. [Example Output](#example-output) - output from a successful call
    1. [Example Error](#example-error) - error output from a unsuccessful call
1. [Vote Fields](#vote-fields) - understanding the result
1. [To Run](#to-run) - Running the example.

### Making the api call

To broadcast the operation, we can use a `Radiator::Transaction` instance:

```ruby
tx = Radiator::Transaction.new


tx.process(true)
```

Passing `true` to `Radiator::Transaction#process` will broadcast the operations queued in the `operations` array of the transaction.

#### Example api call

If we want to vote, for example:

```ruby
tx.operations << {
  type: :vote,
  voter: voter,
  author: author,
  permlink: permlink,
  weight: weight
}
```

#### Example api call using script

And to do the same with our tutorial script:

```bash
ruby vote_on_content.rb https://steemit.com/@inertia/kinda-spooky
```

#### Example Output

From the example we get the following output from our script:

```json
{
  "jsonrpc": "2.0",
  "result": {
    "id": "244a67bf1e64f05fb2ab52a0652a8edd30c5d273",
    "block_num": 27035223,
    "trx_num": 15,
    "expired": false
  },
  "id": 3
}
```

The response we get after broadcasting the transaction gives us the transaction id ([`244a67b...`](https://steemd.com/tx/244a67bf1e64f05fb2ab52a0652a8edd30c5d273)), block number ([`27035223`](https://steemd.com/b/27035223)), and the transaction number of that block (`15`).

Note, this script accepts accepts an optional percentage (defaulting `100.0 %`).  To set the vote to `50.0 %`:

```bash
ruby vote_on_content.rb https://steemit.com/@inertia/kinda-spooky 50
```

### Example Error

If an invalid vote weight is given (e.g.: `101 %`), we will get back an error:

```json
{
  "jsonrpc": "2.0",
  "error": {
    "code": -32000,
    "message": "Assert Exception:abs(weight) <= STEEM_100_PERCENT: Weight is not a STEEMIT percentage",
    "data": {
      "code": 10,
      "name": "assert_exception",
      "message": "Assert Exception",
      "stack": [
        {
          "context": {
            "level": "error",
            "file": "steem_operations.cpp",
            "line": 179,
            "method": "validate",
            "hostname": "",
            "timestamp": "2018-10-22T16:09:50"
          },
          "format": "abs(weight) <= STEEM_100_PERCENT: Weight is not a STEEMIT percentage",
          "data": {
          }
        },
        {
          "context": {
            "level": "warn",
            "file": "database.cpp",
            "line": 3491,
            "method": "_apply_transaction",
            "hostname": "",
            "timestamp": "2018-10-22T16:09:50"
          },
          "format": "",
          "data": {
            "trx": {
              "ref_block_num": 34171,
              "ref_block_prefix": 1240848906,
              "expiration": "2018-10-22T16:19:48",
              "operations": [
                {
                  "type": "vote_operation",
                  "value": {
                    "voter": "social",
                    "author": "inertia",
                    "permlink": "kinda-spooky",
                    "weight": 10100
                  }
                }
              ],
              "extensions": [

              ],
              "signatures": [
                "1c50556b312dd71446621fc3b509da3f5596ab20e8846edd7e55ce5fb13f51742c77d1ab021afa43e039ed2655f28beb1859924ddc6db1087742f3e63e4bc2502b"
              ]
            }
          }
        },
        {
          "context": {
            "level": "warn",
            "file": "database.cpp",
            "line": 817,
            "method": "push_transaction",
            "hostname": "",
            "timestamp": "2018-10-22T16:09:50"
          },
          "format": "",
          "data": {
            "trx": {
              "ref_block_num": 34171,
              "ref_block_prefix": 1240848906,
              "expiration": "2018-10-22T16:19:48",
              "operations": [
                {
                  "type": "vote_operation",
                  "value": {
                    "voter": "social",
                    "author": "inertia",
                    "permlink": "kinda-spooky",
                    "weight": 10100
                  }
                }
              ],
              "extensions": [

              ],
              "signatures": [
                "1c50556b312dd71446621fc3b509da3f5596ab20e8846edd7e55ce5fb13f51742c77d1ab021afa43e039ed2655f28beb1859924ddc6db1087742f3e63e4bc2502b"
              ]
            }
          }
        }
      ]
    }
  },
  "id": 3
}
```

This indicates that the operation was not included in the blockchain because it was given an invalid weight argument.

### Vote Fields

Broadcasting a `vote` operation will require the following fields:

* `voter` - account that is doing the vote op
* `author` - author of the post being voted for
* `permlink` - permlink of the post being voted for
* `weight` - percentage of one vote being cast, expressed as an integer (e.g.: `100.0 %` = `10000`)

### To Run

First, set up your workstation using the steps provided in [Getting Started](https://developers.steem.io/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository) with the following arguments:

* `<url>` - the URL to vote on
* `[weight]` - the weight of the vote as percentage, optional (default `100.0 %`)

```bash
git clone git@github.com:steemit/devportal-tutorials-rb.git
cd devportal-tutorials-rb/tutorials/17_vote_on_content
bundle install
ruby vote_on_content.rb <url> [weight]
```


---
