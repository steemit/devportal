---
title: 'RB: Follow Another User'
position: 18
description: "*How to follow/unfollow another user.*"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Follow Another User](https://github.com/steemit/devportal-tutorials-rb/tree/master/tutorials/18_follow_another_user) can be downloaded as part of the [RB tutorials repository](https://github.com/steemit/devportal-tutorials-rb).</span>
<br>



This tutorial will take you through the process of following/muting/unfollowing/ummuting an author and checking the follow status of an author.

### Sections

1. [Follow](#follow)
1. [Check Follow](#check-follow)
1. [To Run](#to-run) - Running the example.

### Follow

In the first example script, we can modify the initial configuration then run:

```bash
ruby follow.rb
```

Follows (and mutes) are expressed by `custom_json` with `id=follow` (mutes also use `id=follow`).

Example `custom_json` operation:

```json
{
  "id": "follow",
  "required_auths": [],
  "required_posting_auths": ["social"],
  "json": "[\"follow\",{\"follower\":\"social\",\"following\":\"alice\",\"what\":[\"blog\"]}]"
}
```

To broadcast this operation, use the posting `wif` and matching account name in `required_posting_auths`.  There are three variables required in the `json` field of the above operation:

1. `follower` - The specific account that will select the author to follow/unfollow.
2. `following` - The account/author that the account would like to follow.
3. `what` - The type of follow operation.  This variable can have one of three values: `blog` to follow an author, `ignore` to mute, and an empty string to unfollow/unmute.

#### Check Follow

In the second example script:

```bash
ruby check_follow.rb
```

The API method we're using here is `condenser.get_following`.  We pass the name of the account we're checking.  If the account follows more than 1,000 other accounts, we execute `condenser.get_following` multiple times and pass the last followed account we know about to get the next 1,000 (passing the latest `follows.last` each time).

We also specify `blog` to tell the API method that we're looking for followed, not muted (to locate muted accounts, use `ignore` instead of `blog`).

### To Run

First, set up your workstation using the steps provided in [Getting Started](https://developers.steem.io/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository):

```bash
git clone git@github.com:steemit/devportal-tutorials-rb.git
cd devportal-tutorials-rb/tutorials/18_follow_another_user
bundle install
ruby follow.rb
```

### Example Output

```json
{
  "jsonrpc": "2.0",
  "result": {
    "id": "025688e27999d3aa514f1f0b77c9f8d8dae31d72",
    "block_num": 26349355,
    "trx_num": 3,
    "expired": false
  },
  "id": 3
}
```

---
