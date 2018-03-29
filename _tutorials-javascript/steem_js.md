---
title: Steem.js (legacy)
position: 999
description: 
layout: full
right_code: |
    Skeleton
    ``` html
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
    ```
    Script Line
    ``` html
    <script src="https://cdn.steemjs.com/lib/latest/steem.min.js"></script>
    ```
    Post Function
    ``` html
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
    ```
    <p class="right-section-title">Photography</p>
    ~~~javascript
    var results = steem.api.getState('/trending/photography', function(err, result) {
    	console.log(err, result);
    });
    ~~~
    
    ~~~json
    {
     "ats-david/nature-in-black-and-white-volume-iii": {
     "id": 2202087,
     "author": "ats-david",
     "permlink": "nature-in-black-and-white-volume-iii",
     "category": "photography",
     "parent_author": "",
     "parent_permlink": "photography",
     "title": "Nature in Black and White: Volume III",
     "body": "### Do we see the beauty in colorful objects and detailed images the same when color is removed?\n\nHere are more images from my adventures in nature...in black and white, of course.\n\n<hr>\n\n![IMG_0460-3_bw.jpg](https://steemitimages.com/DQmTb3aYwhUqRuWXjUNWFF8BxG98kzinufY3eMtd1Wggnd1/IMG_0460-3_bw.jpg)\n\n<br />\n\n![IMG_0461-2_bw.jpg](https://steemitimages.com/DQmaw6cofwQMKt8Jpj8Em6VxLYLRU1MYCH5aaQAxefLb3wM/IMG_0461-2_bw.jpg)\n\n<br />\n\n![IMG_0462-2_bw.jpg](https://steemitimages.com/DQmZMAgzj81isjeNZeCSxCBD6TKYAG2n6qc6475rrd9wCCG/IMG_0462-2_bw.jpg)\n\n<br />\n\n![IMG_2581-2_bw.jpg](https://steemitimages.com/DQmV3ECCU9pobunhFa1SgPXTQkiEhYijixqgaqM9Q5RhDGG/IMG_2581-2_bw.jpg)\n\n<br />\n\n![IMG_2928-1_bw.jpg](https://steemitimages.com/DQmXcGpQWDXzuEo2XTzJnErG4rjrgwgbr5TQeQpaM1MwRww/IMG_2928-1_bw.jpg)\n\n<br />\n\n![IMG_2912-1_bw.jpg](https://steemitimages.com/DQmfU8spbdp8isEirVPV1B69LeFVwgj2cucCNyA4kEnCB9h/IMG_2912-1_bw.jpg)\n\n<br />\n\n![IMG_2935-1_bw.jpg](https://steemitimages.com/DQmVsQUTkdYYVJu2VyHxA6JmHxZY9Re3Pk3Ldkb6Ky2Gmih/IMG",
     "json_metadata": "{\"tags\":[\"photography\",\"nature\",\"life\",\"travel\",\"blackandwhite\"],\"users\":[\"mynameisbrian\",\"ats-david\"],\"image\":[\"https://steemitimages.com/DQmTb3aYwhUqRuWXjUNWFF8BxG98kzinufY3eMtd1Wggnd1/IMG_0460-3_bw.jpg\",\"https://steemitimages.com/DQmaw6cofwQMKt8Jpj8Em6VxLYLRU1MYCH5aaQAxefLb3wM/IMG_0461-2_bw.jpg\",\"https://steemitimages.com/DQmZMAgzj81isjeNZeCSxCBD6TKYAG2n6qc6475rrd9wCCG/IMG_0462-2_bw.jpg\",\"https://steemitimages.com/DQmV3ECCU9pobunhFa1SgPXTQkiEhYijixqgaqM9Q5RhDGG/IMG_2581-2_bw.jpg\",\"https://steemitimages.com/DQmXcGpQWDXzuEo2XTzJnErG4rjrgwgbr5TQeQpaM1MwRww/IMG_2928-1_bw.jpg\",\"https://steemitimages.com/DQmfU8spbdp8isEirVPV1B69LeFVwgj2cucCNyA4kEnCB9h/IMG_2912-1_bw.jpg\",\"https://steemitimages.com/DQmVsQUTkdYYVJu2VyHxA6JmHxZY9Re3Pk3Ldkb6Ky2Gmih/IMG_2935-1_bw.jpg\",\"https://steemitimages.com/DQmU7DULoUra3yxN9KiUErKpZTf8F33UtjW7KjceZn4hQ8X/IMG_2793_1_bw.jpg\",\"https://steemitimages.com/DQmerT739AigSpyXHEn6ariLENvPB6f4KfEZaWoPbNfJXc8/IMG_2814-1_bw.jpg\",\"https://steemitimages.com/DQmYiU1p14qi57MSw3E8QQJxmeBoMFsJ6TVkXYjGjGcXX6F/IMG_2815-1_bw.jpg\",\"https://steemitimages.com/DQmVHgDLF7PbiamAxqfs66XXwnrfPwXbo4PrKaWCoSTdRA8/IMG_2628-2_bw.jpg\",\"http://www.steemimg.com/images/2017/03/08/ats_content_slayer_bwd9706.md.jpg\"],\"links\":[\"http://www.steemimg.com/image/OPX18\"],\"app\":\"steemit/0.1\",\"format\":\"markdown\"}",
     "last_update": "2017-03-20T20:48:45",
     "created": "2017-03-20T20:48:45",
     "active": "2017-03-21T15:38:51",
     "last_payout": "1970-01-01T00:00:00",
     "depth": 0,
     "children": 11,
     "children_rshares2": "338868651292331066826618722",
     "net_rshares": "16371652797084",
     "abs_rshares": "29650160882494",
     "vote_rshares": "23010906839789",
     "children_abs_rshares": "30710187259990",
     "cashout_time": "2017-03-21T22:47:20",
     "max_cashout_time": "2017-04-03T20:49:18",
     "total_vote_weight": "15714996608417319864",
     "reward_weight": 10000,
     "total_payout_value": "0.000 SBD",
     "curator_payout_value": "0.000 SBD",
     "author_rewards": 0,
     "net_votes": 312,
     "root_comment": 2202087,
     "mode": "first_payout",
     "max_accepted_payout": "1000000.000 SBD",
     "percent_steem_dollars": 10000,
     "allow_replies": true,
     "allow_votes": true,
     "allow_curation_rewards": true,
     "url": "/photography/@ats-david/nature-in-black-and-white-volume-iii",
     "root_title": "Nature in Black and White: Volume III",
     "pending_payout_value": "51.332 SBD",
     "total_pending_payout_value": "52.155 SBD"
      }
     }
    ~~~
    
    ~~~javascript
    for (var results in content) {
        // log each payout amount 
        console.log(pending_payout_value)   
    }
    ~~~
    <p class="right-section-title">Accounts</p>
    ``` javascript
    steem.api.getAccounts(['ned', 'sneak'], function(err, result) {
        console.log(err, result);
    });
    ```
    <p class="right-section-title">State</p>
    ``` javascript
    steem.api.getState('/trends/funny', function(err, result) {
        console.log(err, result);
    });
    ```
    <p class="right-section-title">Broadcast</p>
    ``` javascript
    var steem = require('steem');

    var wif = steem.auth.toWif(username, password, 'posting');
    steem.broadcast.vote(wif, voter, author, permlink, weight, function(err, result) {
        console.log(err, result);
    });
    ```
    <p class="right-section-title">Reputation</p>
    ``` javascript
    var reputation = steem.formatter.reputation(user.reputation);
    console.log(reputation);
    ```
---

<b>Note:</b> Our tutorials use currently use `dsteem`, which is significantly faster on the client, is better documented, and has a strong path forward. If you prefer to use `steem-js` you can find our legacy getting started section [here](https://github.com/steemit/steem-js).

The legacy toolkit Steem.js makes is easy to access the steem blockchain for your project. The Javascript library let's your app easily access steem blockchain data and also perform user actions.

The toolkit is located at: [https://github.com/steemit/steem-js](https://github.com/steemit/steem-js). 

Get running with Steem.js with a few simple options. 

NPM install for Javascript projects. 

```
npm install steem --save
```

Link directly from the CDN. 
```
<script src="//cdn.steemjs.com/lib/latest/steem.min.js"></script>
```

---

### Quickstart

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

### Photography

Utilizing the Javascript library with a few lines of code, display the latest
photography posts, along with payout data. 

You can easily create the next instagram on the steem platform. 

Example site: [snapsteem.com](http://www.snapsteem.com/){:target="_blank"}

##### Let's get started:

Use the get state method to return trending photography posts. 

Displayed is example output of an individual content object returned. 

Last, let's loop over your results and return each payout amount. Using our example above we will have
an object with "content". 

### Accounts

Easily fetch account data on the following users.

### State

Easily fetch state.

### Broadcast

Easily cast a vote for a user.

### Reputation

Easily handle reputation parsing.
