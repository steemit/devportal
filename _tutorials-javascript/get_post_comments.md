---
title: Get Post Comments
position: 7
description: By the end of this tutorial you would know how to get comments made by others on any post
layout: full
---
# How to Get Post Comments

_By the end of this tutorial you would know how to get comments made by others on any post._

The purpose of this tutorial is to **a)** demonstrate how to get a list of articles from the trending list on the blockchain, and **b)** fetch the contents of the selected post to display its title and body and **c)** fetch comments of the post and display them with author, body, created time and number of votes.

We will also explain the most commonly used fields from the response object as well as parse body of each comment.

## Intro

Each post might have comments/replies that is interesting and contributes to the topic and discussion. Steem offers out of box API for pulling replies for particular post with `get_content_replies`. We will fetch replies and list them in simple user interface.

## Steps

1.  [**Fetching posts**](#fetching-posts) Getting trending posts
1.  [**Post comments**](#post-comments) Open post and fetch comments
1.  [**Query result**](#query-result) Result of the query

#### 1. Fetching post<a name="fetching-posts"></a>

As mentioned in our previous tutorials we can fetch various lists of posts with different filters. Here, we are reusing some parts of that tutorial to list the top 5 trending posts. And we parse content of selected post to display few fields in a meaningful way.

#### 2. Post comments<a name="post-comments"></a>

On selection of a particular post from the list, `openPost` function is fired as it is explained in [**Get Post Details**]() tutorial. This function will call the `get_content` function to fetch content of the post. Right after root post is displayed properly, we use `get_content_replies` function to fetch comments made on that post, function requires author and permlink of the root post to fetch its comments.

```javascript
client.database.call('get_content_replies', [author, permlink]).then(result => {
    const comments = [];
    for (var i = 0; i < result.length; i++) {
        comments.push(
            `<div class="list-group-item list-group-item-action flex-column align-items-start">\
            <div class="d-flex w-100 justify-content-between">\
              <h5 class="mb-1">@${result[i].author}</h5>\
              <small class="text-muted">${new Date(
                  result[i].created
              ).toString()}</small>\
            </div>\
            <p class="mb-1">${md.render(result[i].body)}</p>\
            <small class="text-muted">&#9650; ${result[i].net_votes}</small>\
          </div>`
        );
    }

    document.getElementById('postComments').style.display = 'block';
    document.getElementById('postComments').innerHTML = comments.join('');
});
```

We iterate each comment and format them properly in `comments` array. As mentioned in **Get Post Details** tutorial, we use `remarkable` library to parse the body of each comment into a readable format. Author, comment body, created time and number of votes on that comment is displayed with simple user interface.

```javascript
document.getElementById('postList').style.display = 'block';
document.getElementById('postBody').style.display = 'none';
document.getElementById('postComments').style.display = 'none';
```

The "go back" function simply hides and shows the post list.

#### 3. Query result<a name="query-result"></a>

The result is returned from the post content as a `JSON` object with the following properties:

```json
[
    {
        "id": 37338948,
        "author": "demo",
        "permlink": "re-join-team-steemit-at-tokenfest-20180500t181413163z",
        "category": "steemit",
        "parent_author": "steemit",
        "parent_permlink": "join-team-steemit-at-tokenfest",
        "title": "",
        "body": "Thank you for sharing",
        "json_metadata":
            "{\"tags\":[\"steemit\"],\"app\":\"steemit/0.1\",\"format\":\"markdown\"}",
        "last_update": "2018-03-07T23:22:54",
        "created": "2018-05-00T20:56:36",
        "active": "2018-05-06T01:40:21",
        "last_payout": "1970-01-01T00:00:00",
        "depth": 1,
        "children": 1,
        "net_rshares": "11453442114933",
        "abs_rshares": "11454054795840",
        "vote_rshares": "11454054795840",
        "children_abs_rshares": "13568695606090",
        "cashout_time": "2018-05-07T20:56:36",
        "max_cashout_time": "1969-12-31T23:59:59",
        "total_vote_weight": 3462435,
        "reward_weight": 10000,
        "total_payout_value": "0.000 SBD",
        "curator_payout_value": "0.000 SBD",
        "author_rewards": 0,
        "net_votes": 77,
        "root_comment": 37338948,
        "max_accepted_payout": "0.000 SBD",
        "percent_steem_dollars": 10000,
        "allow_replies": true,
        "allow_votes": true,
        "allow_curation_rewards": true,
        "beneficiaries": [],
        "url":
            "/steemit/@steemitblog/join-team-steemit-at-tokenfest#@demo/re-join-team-steemit-at-tokenfest-20180500t181413163z",
        "root_title": "Join Team Steemit at TokenFest!",
        "pending_payout_value": "0.436 SBD",
        "total_pending_payout_value": "0.000 STEEM",
        "active_votes": [
            {
                "voter": "steemitblog",
                "weight": 0,
                "rshares": "1870813909383",
                "percent": 10000,
                "reputation": "128210130644387",
                "time": "2018-03-07T20:56:36"
            },
            {
                "voter": "kevinwong",
                "weight": 526653,
                "rshares": "2208942520687",
                "percent": 5000,
                "reputation": "374133832002581",
                "time": "2018-03-08T04:27:00"
            }
        ],
        "replies": [],
        "author_reputation": "128210130644387",
        "promoted": "0.000 SBD",
        "body_length": 0,
        "reblogged_by": []
    },
    {
        "id": 37338987,
        "etc.": "etc"
    }
]
```

From this result, you have access to comments made on selected post.

### To Run the tutorial

1.  clone this repo
1.  `cd tutorials/07_get_post_comments`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)
