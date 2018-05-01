---
title: Blog Feed
position: 2
exclude: true
layout: full
description: A simple blog feed tutorial using javascript
right_code: |
    <p class="static-right-section-title">index.html</p>
    ``` html
      <html>
      <head><title>User blog</title>
        <script src="bundle.js"></script>
      </head>
      <body>
      <div class="container">
        <h2>Welcome to my blog!</h2>
        <div class="list-group" id="postList"></div>
      </body>
      </html>
    ```
    <p class="static-right-section-title">app.js</p>
    ``` javascript
      const { Client } = require('dsteem');

      const client = new Client('https://api.steemit.com');

      function fetchBlog()
      {
          const query = {
              tag: 'steemitblog',
              limit: 5
          };
          client.database.getDiscussions('trending', query).then((result) => {
              var posts = [];
              result.forEach( (post) => {
                  const image = JSON.parse(post.json_metadata).image[0];
                  const title = post.title;
                  const author = post.author;
                  const created = new Date(post.created).toDateString();
                  posts.push(
                      `<a href="#" class="list-group-item"><h4 class="list-group-item-heading">${title}</h4><p>by ${author}</p><center><img src="${image}" class="img-responsive center-block" style="max-width: 450px"/></center><p class="list-group-item-text text-right text-nowrap">${created}</p></a>`
                  )
              });
              document.getElementById('postList').innerHTML = posts.join();
          }).catch((err) => {
            alert('Error occured');
          });
      }
      window.onload = fetchBlog();
    ```

    <p class="static-right-section-title">index.js</p>
    
    ``` javascript
      const Koa = require('koa');
      const app = new Koa();
      const serve = require('koa-static');
      app.use(serve('./public'));

      app.listen(3000);

      console.log('listening on port 3000');    
    ```
---

In this tutorials we will build simple webapp or blog for particular user on
Steem blockchain using simple HTML and Javascript.

Using the [dsteem](https://github.com/jnordberg/dsteem) library, process is
super easy, fetch user blog posts from blockchain and style them accordingly.

By default the `dsteem` library connects to steemit.com's public Steem nodes. To
kickstart development this is entirely acceptable. If your STEEM app turns into
a larger project and maybe even a full-fledged site you may want to consider
running your own nodes. If you want to use different Steem nodes, it can be
specified with `dsteem` but it's left out for this simple example.

#### Tutorial Setup [<img src="/images/look.svg" width="16" height="16" />](/tutorials-javascript/getting-started)

* clone
  [https://github.com/steemit/devportal-tutorials-js](https://github.com/steemit/devportal-tutorials-js)
* run either `npm i` or `yarn install`
* run `npm run start`
* browse to (http://localhost:4000/)

> The actual tutorial is available in the subfolder of the above repo under the
> url
> [https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/01_blog_feed](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/01_blog_feed)

Open your favorite text editor or IDE (atom, sublimetext, text edit, or even
notepad).

### [index.html](https://github.com/steemit/devportal-tutorials-js/blob/master/tutorials/01_blog_feed/public/index.html)

> Make a basic html file that contains the structure for the javascript to
> populate with results returned by the api. Basic bootstrap styling is used.

### [app.js](https://github.com/steemit/devportal-tutorials-js/blob/master/tutorials/01_blog_feed/public/app.js)

> A seperate javascript file exists with the application to query the API and
> populate the HTML document with the results returned. We are calling
> `fetchBlog()` function when body of the page is onload.

### [index.js](https://github.com/steemit/devportal-tutorials-js/blob/master/tutorials/01_blog_feed/index.js)

> index.js is a basic javascript file that loads a `koa` based webserver serving
> the tutorial so you can access it via a browser

#### fetchBlog

> **fetchBlog** function creates simple query object where tag is set to account
> name on Steem and limit is set to number of posts being pulled from that
> account. By using `client.database.getDiscussions` dsteem function we are able
> to query user's blog posts and reformat them into list of posts. Each blog
> post has `json_metadata` which holds meta information in post, using that we
> are able to extract first image from post and use it as thumbnail, post author
> and created information is also formated and displayed.

```javascript
var query = {
  tag: 'steemitblog', // This tag is used to filter the results by a specific post tag
  limit: 5 // This limit allows us to limit the overall results returned to 5
};
```

`tag` - this [tag](/glossary/#Tags) is used to limit the types of posts that are
returned. Each post is assigned multiple tags appon creation and by doing this
allows you to filter what results are returned.

`limit` - this limit allows us to limit the amount of records that are returned
on a query. By not having a limit you could returned a large amount of data
which might cause performance issues. By limiting the amount of results you
return a smaller subset of data that you can work with.

Place **script line** and **fetchBlog** function into `<head>` and save the file
as `user-blog.html` and load it in your web browser. That's it, congratulations
on your first app!

#### JSON Result

> A sample of the JSON returned by the `fetchBlog()` function is set out below.
> Key items to note are the following

* url - This allows you to link back to the original article on Steem
* json_metadata - This contains custom specific information for the post. It is
  a JSON object which must be parsed using `JSON.parse` to access. For posts
  this contains the image URL that is stored online

```json
{% include tutorials-javascript/blog_feed.json %}
```
