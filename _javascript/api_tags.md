---
title: Tags and Categories
position: 4
right_code: |
    <p class="right-section-title">Get Trending Tags</p>
    ```javascript
    steem.api.getTrendingTags(afterTag, limit, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Discussions By Trending</p>
    ```javascript
    steem.api.getDiscussionsByTrending(query, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Discussions By Created</p>
    ```javascript
    steem.api.getDiscussionsByCreated(query, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Discussions By Active</p>
    ```javascript
    steem.api.getDiscussionsByActive(query, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Discussions By Cashout</p>
    ```javascript
    steem.api.getDiscussionsByCashout(query, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Discussions By Payout</p>
    ```javascript
    steem.api.getDiscussionsByPayout(query, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Discussions By Votes</p>
    ```javascript
    steem.api.getDiscussionsByVotes(query, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Discussions By Children</p>
    ```javascript
    steem.api.getDiscussionsByChildren(query, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Discussions By Hot</p>
    ```javascript
    steem.api.getDiscussionsByHot(query, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Discussions By Feed</p>
    ```javascript
    steem.api.getDiscussionsByFeed(query, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Discussions By Blog</p>
    ```javascript
    steem.api.getDiscussionsByBlog(query, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Discussions By Comments</p>
    ```javascript
    steem.api.getDiscussionsByComments(query, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Trending Categories</p>
    ```javascript
    steem.api.getTrendingCategories(after, limit, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Best Categories</p>
    ```javascript
    steem.api.getBestCategories(after, limit, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Active Categories</p>
    ```javascript
    steem.api.getActiveCategories(after, limit, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Recent Categories</p>
    ```javascript
    steem.api.getRecentCategories(after, limit, function(err, result) {
      console.log(err, result);
    });
    ```

---

Access tags, filter by type.
