---
title: Get posts with filters
position: 5
description: How to query for posts with specific filters & tags.
layout: full
right_code: |
    <p class="static-right-section-title">Filters or tags</p>
    ``` javascript
    filtersChange = async() => {
        filter = document.getElementById("filters").value
        const query = {
            tag: '',
            limit: 5
        };
        client.database.getDiscussions(filter, query).then((result) => {
            if (result){
                var posts = [];
                result.forEach( (post) => {
                    const json = JSON.parse(post.json_metadata);
                    const image = json.image?json.image[0]:'';
                    const title = post.title;
                    const author = post.author;
                    const created = new Date(post.created).toDateString();
                    posts.push(
                        `<div class="list-group-item"><h4 class="list-group-item-heading">${title}</h4><p>by ${author}</p><center><img src="${image}" class="img-responsive center-block" style="max-width: 450px"/></center><p class="list-group-item-text text-right text-nowrap">${created}</p></div>`
                    )
                });

                document.getElementById('postList').innerHTML = posts.join('');
            }
            
        }).catch((err) => {
            console.log(err);
            alert('Error occured, try again');
        });
    ```
---

This tutorial pulls a list of the posts from different tag or filters and displays them. Source code for this tutorial can be found here: [devportal-tutorials-js/tutorials/04_get_posts](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/04_get_posts).

### Filters

In Steem there are built-in filters `trending`, `hot`, `new`, `active`, `promoted` etc. which help us to get list of posts. `client.database.getDiscussions(filter, query)` first argument of this function is one of above filter and library fetches posts from those filters.

### Query (tag, limit)

Second argument of `getDisccusions` function is query.

*   You can add a tag to filter the posts that you receive from the server, if this field is empty string it will fetch from full list of posts in that selected tag.
*   You can also limit the number of results you would like to receive from the query

```javascript
var query = {
    tag: '', // This tag is used to filter the results by a specific post tag
    limit: 5, // This limits the overall results returned to 5
};
```

### Query Result

The result returned form the service is a `JSON` object with the following properties:

```json
{% include tutorials-javascript/get_posts.json %}
```

From this result you have access to everything associated with each post including additional metadata which is a `JSON` string that must be decoded to use. This `JSON` object has additional information and properties for the post including a reference to the image uploaded.

`JSON` contains list of posts with their properties, in our example we choose limit 5 which means we will recieve 5 posts in json object. After parsing additional information we will be able to display them as we want.

### To run

*   git clone https://github.com/steemit/devportal-tutorials-js/
*   cd devportal-tutorials-js/tutorials/04_get_posts
*   npm i
*   npm run start