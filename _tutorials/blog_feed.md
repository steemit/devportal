---
title: User blog
position: 3
right_code: |
    Skeleton
    ``` html
    <html>
    <head><title>User blog</title></head>
    <body onload="fetchBlog()">
    <div class="container">
      <h2>Welcome to my blog!</h2>
      <div class="list-group" id="postList"></div>
    </body>
    </html>
    ```
    Script Line
    ``` html
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.steemjs.com/lib/latest/steem.min.js"></script>
    ```
    fetchBlog Function
    ``` html
    <script language="JavaScript">
    function fetchBlog()
    {
        var query = {
          tag: 'steemitblog',
          limit: 5
        };
        steem.api.getDiscussionsByBlog(query, function(err, result) {
          var posts = '';
          for (var i = 0; i < result.length; i++) {
            var image = JSON.parse(result[i].json_metadata).image[0];
            posts += 
            '<a href="#" class="list-group-item"><h4 class="list-group-item-heading">'+result[i].title+'</h4><p>by '+result[i].author+'</p><center><img src='+image+' class="img-responsive center-block" style="max-width: 450px"/></center><p class="list-group-item-text text-right text-nowrap">'+new Date(result[i].created).toDateString()+'</p></a>';
          }
          document.getElementById('postList').innerHTML = posts;
        });
    }
    </script>
    ```
---

In this tutorials we will build simple webapp or blog for particular user on Steem blockchain using simple HTML and Javascript.

Using the steem-js library, process is super easy, fetch user blog posts from blockchain and style them accordingly.

By default the steem-js library connects to steemit.com's public Steem nodes. To kickstart development this is entirely acceptable. If your STEEM app turns into a larger project and maybe even a full-fledged site you may want to consider running your own nodes. If you want to use different Steem nodes, it can be specified with steem-js but it's left out for this simple example.

Open your favorite text editor or IDE (atom, sublimetext, text edit, or even notepad).

Make a basic **skeleton** of a webpage in HTML to use as your 'interface'. In our example we using simple bootstrap to style content, but you can choose any styling options you want. 

Script line - includes basic bootstrap stylesheet and libraries, note we have included inline steem-js library from public available CDN. We are calling `fetchBlog()` function when body of the page is onload. 

fetchBlog - function creates simple query object where tag is set to account name on Steem and limit is set to number of posts being pulled from that account. By using `steem.api.getDiscussionsByBlog` steem-js function we are able to query user's blog posts and reformat them into list of posts.
Each blog post has `json_metadata` which holds meta information in post, using that we are able to extract first image from post and use it as thumbnail, post author and created information is also formated and displayed.


Place **script line** and **fetchBlog** function into `<head>` and save the file as `user-blog.html` and load it in your web browser. That's it, congratulations on your first app!
