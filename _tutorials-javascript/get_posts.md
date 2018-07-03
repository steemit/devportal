---
title: Get Posts
position: 4
description: Query for the most recent posts having a specific tag using a Steem filter
layout: full
---


This tutorial pulls a list of the posts from different tags or filters and displays them.
Tags and filters are different. It's important to understand them.

## Intro

Tags & Filters are two different.

A `tag` in Steem is much like a tag in Gmail, or Twitter. It's a way to describe a
post as being relevant to a particular topic. Posts may have up to five tags on them, but there are limits when
querying (more on this later).

A `filter` in Steem is a kind of built-in 'view' or ordering of posts. You can use the following filters:
`trending`, `hot`, `new`, `active`, and `promoted`. You'll get a feel for the subtleties of each as you create your
application.

## Steps

1.  [**UI**](#UI) - A brief description of the UI and inputting our query values
1.  [**Construct query**](#Construct-query) - Assemble the information from the UI into our `filter` & `query`
1.  [**API call**](#API-call) - Make the call to Steem
1.  [**Handle response**](#Handle-response) - Accept the response in a promise callback, then render the results
1.  [**Example post object**](#Example-post-object) - An example post object from the response list

#### 1. UI <a name="UI"></a>

The source HTML for our UI can be found in [public/index.html](./public/index.html)

There are three input components to the UI.

*   Filters: where we select one of the five built in filter types.

    `<select id="filters" class="form-control" >...`

*   Tag: where we type in a _single_, arbitrary tag. (The Steem blockchain does not support searching on multiple tags)

    `<input id="tag" class="form-control"/>`

*   Get Posts: It's a button. You click it, and we move on to assembling our post.
    `<button class="btn btn-primary" onclick="getPosts()">Get Posts</button>`

![Step-01-UI.png](https://github.com/steemit/devportal-tutorials-js/blob/master/tutorials/04_get_posts/images/Step-01-UI.png?raw=true)

#### 2. Construct query <a name="Construct-query"></a>

The filter and query are constructed within the async, globally available function `getPosts`

The `limit` property you see below limits the total number of posts we'll get back to something
managable. In this case, five.

```javascript
const filter = document.getElementById('filters').value;
const query = {
    tag: document.getElementById('tag').value,
    limit: 5,
};
```

#### 3. API call <a name="API-call"></a>

The api call itself is fairly simple. We use `getDiscussions`.
The first argument, filter, is a simple string.
The second argument is our query object.
Like most of dsteem's api functions, `getDiscussions` returns a [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise).

```javascript
client.database
    .getDiscussions(filter, query)
    .th..
```

#### 4. Handle response <a name="Handle-response"></a>

When the promise returned by `getDiscussions` completes successfully, the function we pass to `.then()`
iterates over the entries response, and constructs html from it.

```javascript
...ery)
.then(result => {
            console.log("Response received:", result);
            if (result) {
                var posts = [];
                result.forEach(post => {
                    const json = JSON.parse(post.json_metadata);
                    const image = json.image ? json.image[0] : '';
                    const title = post.title;
                    const author = post.author;
                    const created = new Date(post.created).toDateString();
                    posts.push(
                        `<div class="list-group-item"><h4 class="list-group-item-heading">${title}</h4><p>by ${author}</p><center><img src="${image}" class="img-responsive center-block" style="max-width: 450px"/></center><p class="list-group-item-text text-right text-nowrap">${created}</p></div>`
                    );
                });

                document.getElementById('postList').innerHTML = posts.join('');
            } else {
                document.getElementById('postList').innerHTML = "No result.";
            }
        })
```

#### 5. Example post object <a name="Example-post-object"></a>

The result returned from the service is a `JSON` list. This is an example list with one entry.

```json
[
    {
        "id": 37338948,
        "author": "steemitblog",
        "permlink": "join-team-steemit-at-tokenfest",
        "category": "steemit",
        "parent_author": "",
        "parent_permlink": "steemit",
        "title": "Join Team Steemit at TokenFest!",
        "body":
            "<a href=\"https://tokenfest.adria.digital\"><img src=\"https://i.imgur.com/fOScDIW.png\"/></a>\n\nHello Steemians! If you’d like to meet Team Steemit live-in-person, or are just interested in attending what promises to be a great blockchain conference, join us at <a href=\"https://tokenfest.adria.digital/\">TokenFest</a> in San Francisco from March 15th to 16th. \n\nSteemit CEO, Ned Scott, will be participating in a fireside chat alongside Steemit’s CTO, Harry Schmidt, as well as the creator of Utopian.io, Diego Pucci. Steemit will also be hosting the opening party on Thursday night and we’d certainly love to meet as many of you as possible IRL, so head on over to https://tokenfest.adria.digital/ and get your tickets while you can. \n\n*Team Steemit*",
        "json_metadata":
            "{\"tags\":[\"steemit\",\"tokenfest\",\"conference\"],\"image\":[\"https://i.imgur.com/fOScDIW.png\"],\"links\":[\"https://tokenfest.adria.digital\",\"https://tokenfest.adria.digital/\"],\"app\":\"steemit/0.1\",\"format\":\"markdown\"}",
        "last_update": "2018-03-07T23:22:54",
        "created": "2018-03-07T20:56:36",
        "active": "2018-03-13T01:40:21",
        "last_payout": "1970-01-01T00:00:00",
        "depth": 0,
        "children": 29,
        "net_rshares": "11453442114933",
        "abs_rshares": "11454054795840",
        "vote_rshares": "11454054795840",
        "children_abs_rshares": "13568695606090",
        "cashout_time": "2018-03-14T20:56:36",
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
        "url": "/steemit/@steemitblog/join-team-steemit-at-tokenfest",
        "root_title": "Join Team Steemit at TokenFest!",
        "pending_payout_value": "46.436 SBD",
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
        "body_length": 754,
        "reblogged_by": []
    }
    ...
]
```

**And that's all there is to getting top-level posts.** _See [Get post comments](../07_get_post_comments) for getting comments_

### To Run the tutorial

1.  clone this repo
1.  `cd tutorials/04_get_posts`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)
