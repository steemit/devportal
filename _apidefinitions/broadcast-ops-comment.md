# API: `broadcast.comment`

This is a brief overview of the parameters allowed and values passed by the `comment` operation.
Additional info for API definitions is available on the [dev portal](https://developers.steem.io/apidefinitions/#broadcast_ops_comment)

## Purpose

A broadcast operation on Steem is a way of expressing intention on the blockchain. They have types, like `comment` in this instance, and they pass parameters (like author) depending on what their intended use is. In other words, the `broadcast.comment` operation creates a post or a comment on a current post, on the steem blockchain.

## Rules

 * The `title` must not be longer than 256 bytes
 * The `title` must be UTF-8
 * The `body` must be larger than 0 bytes
 * The `body` much also be UTF-8

## Parameters

 * `parent_author` - author that post/comment is being submitted to
 * `parent_permlink` - specific post that comment is being submitted to
 * `author` - author of the post/comment being submitted (username)
 * `permlink` - unique identifier for the post linked to the author of the post
 * `title` - title of the post being submitted
 * `body` - body of the post/comment being submitted
 * `json_metadata` - post tags in the form of an array

Typically a `comment` operation would look similar to the below:

```javascript
    const post = {
        author: "Joe",
        title: "A post by Joe",
        body: "Look at my awesome post",
        parent_author: '',
        parent_permlink: "steem",
        permlink: "a-post-by-joe",
        json_metadata: "{\"tags\":[\"steemit\",\"example\",\"tags\"]}",
    };
```

In which case the complete `broadcast` operation would look like this:

```javascript
    broadcast.comment(post, privatePostingKey)
```