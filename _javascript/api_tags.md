---
title: Tags and Categories
position: 4
right_code: |
    <p class="right-section-title">Get Trending Tags</p>
    ~~~javascript
    steem.api.getTrendingTags(afterTag, limit, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Discussions By Trending</p>
    ~~~javascript
    steem.api.getDiscussionsByTrending(query, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Discussions By Created</p>
    ~~~javascript
    steem.api.getDiscussionsByCreated(query, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Discussions By Active</p>
    ~~~javascript
    steem.api.getDiscussionsByActive(query, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Discussions By Cashout</p>
    ~~~javascript
    steem.api.getDiscussionsByCashout(query, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Discussions By Payout</p>
    ~~~javascript
    steem.api.getDiscussionsByPayout(query, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Discussions By Votes</p>
    ~~~javascript
    steem.api.getDiscussionsByVotes(query, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Discussions By Children</p>
    ~~~javascript
    steem.api.getDiscussionsByChildren(query, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Discussions By Hot</p>
    ~~~javascript
    steem.api.getDiscussionsByHot(query, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Discussions By Feed</p>
    ~~~javascript
    steem.api.getDiscussionsByFeed(query, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Discussions By Blog</p>
    ~~~javascript
    steem.api.getDiscussionsByBlog(query, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Discussions By Comments</p>
    ~~~javascript
    steem.api.getDiscussionsByComments(query, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Trending Categories</p>
    ~~~javascript
    steem.api.getTrendingCategories(after, limit, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Best Categories</p>
    ~~~javascript
    steem.api.getBestCategories(after, limit, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Active Categories</p>
    ~~~javascript
    steem.api.getActiveCategories(after, limit, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Recent Categories</p>
    ~~~javascript
    steem.api.getRecentCategories(after, limit, function(err, result) {
      console.log(err, result);
    });
    ~~~

---

Access tags, filter by type.

Many of these functions take a `query` parameter; the structure of this parameter is an object with several keys that indicate what is to be searched for:

~~~javascript
var query = {
  tag: 'photography',
  limit: 20,
  truncate_body: 0
};
~~~

|Property|Value|
|---|---|
|`tag`|String value to search for|
|`limit`|How many results to return (max of 100). Allows paginating results, combined with the different `start_` properties|
|`select_authors`|List of authors to include, posts not by this author are filtered|
|`select_tags`|List of tags to include, posts without these tags are filtered|
|`truncate_body`|The number of bytes of the post body to return, 0 for all|
|`start_author`|Optional. Start the result set at the given author's content|
|`start_permlink`|Optional. Unique ID of the content item to start the results at|

### Get Trending Tags
Get a list of tags that have the most upvoted content currently. Takes two arguments to control pagination.

|Argument|Value|
|---|---|
|`afterTag`|The name of the tag to start the result set at. Pass in the last item of the last page fetched to get the next page|
|`limit`|How many results to return.|

### Get Discussions By Trending
Get a listing of comments ordered with the ones that have a lot of activity (weighted by stake) over the past few days (paralleling "trending topics" concepts on other social media platforms).

|Argument|Value|
|---|---|
|`query`|Javascript object with [individual properties](#javascriptapi_tags) set|
|`query.tag`|Limits results to comments that include this keyword|

### Get Discussions By Created
Get a listing of comments ordered with the ones that were created most recently first (note this does not include modifications/updates to the comment or upvotes of the comment; that would be the _active_ sorting).

|Argument|Value|
|---|---|
|`query`|Javascript object with [individual properties](#javascriptapi_tags) set|
|`query.tag`|Limits results to comments that include this keyword|

### Get Discussions By Active
Get a listing of comments ordered with the ones that have been modified, upvoted, or replied to most recently.

|Argument|Value|
|---|---|
|`query`|Javascript object with [individual properties](#javascriptapi_tags) set|
|`query.tag`|Limits results to comments that include this keyword|


### Get Discussions By Cashout
Get a listing of comments ordered by those that have received the most STEEM Dollars (SBD) cashouts first.

|Argument|Value|
|---|---|
|`query`|Javascript object with [individual properties](#javascriptapi_tags) set|
|`query.tag`|Limits results to comments that include this keyword|


### Get Discussions By Payout
Get a listing of comments ordered by those that have received the most STEEM power payouts first.

|Argument|Value|
|---|---|
|`query`|Javascript object with [individual properties](#javascriptapi_tags) set|
|`query.tag`|Limits results to comments that include this keyword|


### Get Discussions By Votes
Get a listing of comments ordered by those that have the most number of votes (not accounting for the weight/stake of the vote) first.

|Argument|Value|
|---|---|
|`query`|Javascript object with [individual properties](#javascriptapi_tags) set|
|`query.tag`|Limits results to comments that include this keyword|


### Get Discussions By Children
Get a listing of comments ordered by those that have the most number of replies first.

|Argument|Value|
|---|---|
|`query`|Javascript object with [individual properties](#javascriptapi_tags) set|
|`query.tag`|Limits results to comments that include this keyword|


### Get Discussions By Hot
Get a listing of comments ordered by ones that have a lot of activity right now, but are also very new (so aren't considered _trending_ yet, but could be).

|Argument|Value|
|---|---|
|`query`|Javascript object with [individual properties](#javascriptapi_tags) set|
|`query.tag`|Limits results to comments that include this keyword|

### Get Discussions By Feed
Get a listing of posts for a given user. The feed for a given user includes posts from authors that user is following.

|Argument|Value|
|---|---|
|`query`|Javascript object with [individual properties](#javascriptapi_tags) set|
|`query.tag`|The username that the feed should be generated for|

### Get Discussions By Blog
Get a listing of posts authored by a given user.

|Argument|Value|
|---|---|
|`query`|Javascript object with [individual properties](#javascriptapi_tags) set|
|`query.tag`|Username to return a listing for|

### Get Discussions By Comments
Get a listing of comments authored by a given user.

|Argument|Value|
|---|---|
|`query`|Javascript object with [individual properties](#javascriptapi_tags) set|
|`query.tag`|Username to return a listing for|


### Get Trending Categories
Get a listing of categories ordered with the ones that have posts with a lot of activity (weighted by stake) over the past few days (paralleling "trending topics" concepts on other social media platforms).

|Argument|Value|
|---|---|
|`after`|The name of the category to start the result set at. Pass in the last item of the last page fetched to get the next page|
|`limit`|How many results to return.|

### Get Best Categories

|Argument|Value|
|---|---|
|`after`|The name of the category to start the result set at. Pass in the last item of the last page fetched to get the next page|
|`limit`|How many results to return.|

### Get Active Categories
Get a listing of categories ordered with the ones that have posts that have been modified, upvoted, or replied to most recently.

|Argument|Value|
|---|---|
|`after`|The name of the category to start the result set at. Pass in the last item of the last page fetched to get the next page|
|`limit`|How many results to return.|

### Get Recent Categories

|Argument|Value|
|---|---|
|`after`|The name of the category to start the result set at. Pass in the last item of the last page fetched to get the next page|
|`limit`|How many results to return.|
