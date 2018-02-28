---
title: Content
position: 12
right_code: |
    <p class="right-section-title">Get Content Replies</p>
     ```javascript
    steem.api.getContentReplies(parent, parentPermlink, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Discussions By Author Before Date</p>
     ```javascript
    steem.api.getDiscussionsByAuthorBeforeDate(author, startPermlink, beforeDate, limit, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Replies By Last Update</p>
    ```javascript
    steem.api.getRepliesByLastUpdate(startAuthor, startPermlink, limit, function(err, result) {
      console.log(err, result);
    });
    ```
---
