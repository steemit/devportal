---
title: 'RB: Reblogging Post'
position: 14
description: "To reblog ('resteem') a post, we can use a custom json operation that is handled by the follow plugin."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Reblogging Post](https://github.com/steemit/devportal-tutorials-rb/tree/master/tutorials/14_reblogging_post) can be downloaded as part of the [RB tutorials repository](https://github.com/steemit/devportal-tutorials-rb).</span>
<br>



For this operation, we will use `custom_json` and a properly formed id and payload so that `follow_plugin` will pick up the reblog data and display the selected post in the feed of the account doing the reblog.

### Sections

1. [Making the api call](#making-the-api-call) - broadcasting the operation
    1. [Example api call](#example-api-call) - make the call in code
    1. [Example api call using script](#example-api-call-using-script) - using our tutorial script
    1. [Example Output](#example-output) - output from a successful call
    1. [Example Error](#example-error) - error output from a unsuccessful call
1. [Custom JSON Fields](#custom-json-fields) - understanding the result
1. [To Run](#to-run) - Running the example.

### Making the api call

To broadcast the operation, we can use a `Radiator::Transaction` instance:

```ruby
tx = Radiator::Transaction.new


tx.process(true)
```

Passing `true` to `Radiator::Transaction#process` will broadcast the operations queued in the `operations` array of the transaction.

#### Example api call

If we want to reblog, we need to form the `json` properly, for example:

```ruby
data = [
  :reblog, {
    account: reblogger,
    author: author,
    permlink: permlink
  }
]

tx.operations << {
  type: :custom_json,
  id: 'follow',
  required_auths: [],
  required_posting_auths: [reblogger],
  json: data.to_json
}
```

#### Example api call using script

And to do the same with our tutorial script:

```bash
ruby reblogging_post.rb https://steemit.com/@inertia/kinda-spooky
```

#### Example Output

From the example we get the following output from our script:

```json
{
  "jsonrpc": "2.0",
  "result": {
    "id": "0aa41e06b2612315d32cadeb671eb1201f266dd7",
    "block_num": 24063620,
    "trx_num": 19,
    "expired": false
  },
  "id": 3
}
```

The response we get after broadcasting the transaction gives us the transaction id ([`0aa41e0...`](https://steemd.com/tx/0aa41e06b2612315d32cadeb671eb1201f266dd7)), block number ([`24063620`](https://steemd.com/b/24063620)), and the transaction number of that block (`19`).

### Example Error

If a post has already been reblogged by the account, we will get back an error:

```json
{
  "jsonrpc": "2.0",
  "error": {
    "code": -32000,
    "message": "Assert Exception:blog_itr == blog_comment_idx.end(): Account has already reblogged this post",
    "data": {
      "code": 10,
      "name": "assert_exception",
      "message": "Assert Exception",
      "stack": [
        {
          "context": {
            "level": "error",
            "file": "follow_evaluators.cpp",
            "line": 143,
            "method": "do_apply",
            "hostname": "",
            "timestamp": "2018-07-10T21:33:11"
          },
          "format": "blog_itr == blog_comment_idx.end(): Account has already reblogged this post",
          "data": {
          }
        },
        {
          "context": {
            "level": "warn",
            "file": "follow_evaluators.cpp",
            "line": 216,
            "method": "do_apply",
            "hostname": "",
            "timestamp": "2018-07-10T21:33:11"
          },
          "format": "",
          "data": {
            "o": {
              "account": "social",
              "author": "inertia",
              "permlink": "kinda-spooky"
            }
          }
        },
        {
          "context": {
            "level": "warn",
            "file": "generic_custom_operation_interpreter.hpp",
            "line": 195,
            "method": "apply",
            "hostname": "",
            "timestamp": "2018-07-10T21:33:11"
          },
          "format": "",
          "data": {
            "outer_o": {
              "required_auths": [

              ],
              "required_posting_auths": [
                "social"
              ],
              "id": "follow",
              "json": "[\"reblog\",{\"account\":\"social\",\"author\":\"inertia\",\"permlink\":\"kinda-spooky\"}]"
            }
          }
        },
        {
          "context": {
            "level": "warn",
            "file": "database.cpp",
            "line": 3221,
            "method": "_apply_transaction",
            "hostname": "",
            "timestamp": "2018-07-10T21:33:11"
          },
          "format": "",
          "data": {
            "op": {
              "type": "custom_json_operation",
              "value": {
                "required_auths": [

                ],
                "required_posting_auths": [
                  "social"
                ],
                "id": "follow",
                "json": "[\"reblog\",{\"account\":\"social\",\"author\":\"inertia\",\"permlink\":\"kinda-spooky\"}]"
              }
            }
          }
        },
        {
          "context": {
            "level": "warn",
            "file": "database.cpp",
            "line": 3227,
            "method": "_apply_transaction",
            "hostname": "",
            "timestamp": "2018-07-10T21:33:11"
          },
          "format": "",
          "data": {
            "trx": {
              "ref_block_num": 12404,
              "ref_block_prefix": 1445149887,
              "expiration": "2018-07-10T21:43:09",
              "operations": [
                {
                  "type": "custom_json_operation",
                  "value": {
                    "required_auths": [

                    ],
                    "required_posting_auths": [
                      "social"
                    ],
                    "id": "follow",
                    "json": "[\"reblog\",{\"account\":\"social\",\"author\":\"inertia\",\"permlink\":\"kinda-spooky\"}]"
                  }
                }
              ],
              "extensions": [

              ],
              "signatures": [
                "1c063e22868f107dbafaa0452d86cfe19894f2f7fc3ea46b5c73dc7906edcd88244548f001c1d128aa07f862819e80e2f46b6cd74c6769d1d48ef4ad1f147b4dab"
              ]
            }
          }
        },
        {
          "context": {
            "level": "warn",
            "file": "database.cpp",
            "line": 788,
            "method": "push_transaction",
            "hostname": "",
            "timestamp": "2018-07-10T21:33:11"
          },
          "format": "",
          "data": {
            "trx": {
              "ref_block_num": 12404,
              "ref_block_prefix": 1445149887,
              "expiration": "2018-07-10T21:43:09",
              "operations": [
                {
                  "type": "custom_json_operation",
                  "value": {
                    "required_auths": [

                    ],
                    "required_posting_auths": [
                      "social"
                    ],
                    "id": "follow",
                    "json": "[\"reblog\",{\"account\":\"social\",\"author\":\"inertia\",\"permlink\":\"kinda-spooky\"}]"
                  }
                }
              ],
              "extensions": [

              ],
              "signatures": [
                "1c063e22868f107dbafaa0452d86cfe19894f2f7fc3ea46b5c73dc7906edcd88244548f001c1d128aa07f862819e80e2f46b6cd74c6769d1d48ef4ad1f147b4dab"
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

This indicates that the operation was not included in the blockchain because it was already reblogged in the past.

### Custom JSON Fields

Broadcasting a `custom_json` operation will require the following fields:

* `id` - set to `follow` to indicate that this operation is handled by the `follow_plugin`
* `required_auths` - leave this as an empty JSON Array, we only need the posting authority
* `required_posting_auths` - JSON Array containing the account name with the posting authority
* `json` - the actual payload of the operation, containing a JSON Array:
  * First element - `reblog`
  * Second element - JSON Object containing:
    * `account` - account that is doing the reblog op
    * `author` - author of the post being reblogged
    * `permlink` - permlink of the post being reblogged

### To Run

First, set up your workstation using the steps provided in [Getting Started](https://developers.steem.io/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository):

* `<url>`

```bash
git clone git@github.com:steemit/devportal-tutorials-rb.git
cd devportal-tutorials-rb/tutorials/14_reblogging_post
bundle install
ruby reblogging_post.rb <url>
```


---
