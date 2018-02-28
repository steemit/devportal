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
