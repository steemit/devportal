---
title: Example
position: 3
right_code: |
    Skeleton
    ~~~html
    <html>
    <head><title>steem-js posting example</title></head>
    <body>
    <h2>Post an article to the steem blockchain!</h2>
    Username: <input id="username" type="text"><br/>
    Posting key: <input id="postingKey" type="password" size="65"><br/>
    Title of article: <input id="title" type="text"><br/>
    Article text:<br/>
    <textarea id="article"></textarea><br/>
    <input id="postIt" type="button" value="Post it!" onClick=postArticle()>
    </body>
    </html>
    ~~~
    Script Line
    ~~~html
    <script src="https://cdn.steemjs.com/lib/latest/steem.min.js"></script>
    ~~~
    Post Function
    ~~~html
    <script language="JavaScript">
    function postArticle()
    {
      steem.broadcast.comment(
        document.getElementById('postingKey').value, // posting wif
        '', // author, leave blank for new post
        'steemtest', // first tag
        document.getElementById('username').value, // username
        'name-of-my-test-article-post', // permlink
        document.getElementById('title').value, // Title
        document.getElementById('article').value, // Body of post
        // json metadata (additional tags, app name, etc)
        { tags: ['secondtag'], app: 'steemjs-test!' },
        function (err, result) {
          if (err)
            alert('Failure! ' + err);
          else
            alert('Success!');
        }
      );
    }
    </script>
    ~~~
---

This is a simple example of how to post an article to the STEEM blockchain using the steem-js library. For the purpose of the example, it's done with inline javascript in an HTML file.

Accompanying youtube tutorial:
https://youtu.be/6Sy33DnyGs8

The tutorial assumes some basic knowledge of both HTML and javascript. For simplicity, this is done with a single HTML file and inline javascript.

By default the steem-js library connects to steemit.com's public STEEM nodes. To kickstart 3rd party development projects this is entirely acceptable. If your STEEM app turns into a larger project and maybe even a full-fledged site you may want to consider running your own nodes. If you want to use different nodes, the RPC endpoint can be specified but it's left out for this simple example.

Open your favorite text editor or IDE (atom, sublimetext, text edit, or even notepad).

Make a basic **skeleton** of a webpage in HTML to use as your 'interface'. Include input boxes for username, posting key, title, and a textarea for the body of the article.

Add a **script line** to pull in the steem-js library inline.

Create a **post function** that uses the steem-js function `steem.broadcast.comment()` to make a post. As far as the blockchain is concerned, a new article/post is the same as a comment, you actually use the same function for both.

Save the file as `steempostexample.html` and load it in your web browser. That's it!

