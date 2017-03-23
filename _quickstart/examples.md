---
title: Examples
position: 2
right_code: |
    ~~~ javascript
    var results = steem.api.getState('/trending/photography', function(err, result) {
    	console.log(err, result);
    });
    ~~~
    {: title="Get State Photo Posts"}
    
     ~~~ javascript
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
    {: title="Example content"}
    
    ~~~ javascript
    for (var results in content) {
        // log each payout amount 
        console.log(pending_payout_value)   
    }
    ~~~
    {: title="Loop payout results"}
---

Utilizing the Javascript library with a few lines of code, display the latest
photography posts, along with payout data. 

You can easily create the next instagram on the steem platform. 

Example site: [snapsteem.com](http://www.snapsteem.com/){:target="_blank"}

##### Let's get started:
<br/>
Use the get state method to return trending photography posts. 

~~~ javascript
var results = steem.api.getState('/trending/photography', function(err, result) {
    console.log(err, result);
});
~~~

Displayed is example output of each content returned. 

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

Last, let's loop over your results and return each payout amount. Using our example above we will have
an object with "content". 

~~~ javascript
for (var results in content) {
    // log each payout amount 
    console.log(pending_payout_value)   
}
~~~


