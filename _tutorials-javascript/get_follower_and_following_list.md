---
title: 'JS: Get Follower And Following List'
position: 19
description: By the end of this tutorial you should know how to create a list of followers and users that you are following
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get Follower And Following List](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/19_get_follower_and_following_list) can be downloaded as part of the [JS tutorials repository](https://github.com/steemit/devportal-tutorials-js).</span>
<br>



This tutorial will take you through the process of calling both the `follower` and `following` functions from the STEEM API.

## Intro

We are using the `call` operation provided by the `dsteem` library to pull the follow information for a specified user account. There are 4 variables required to execute this operation:

1. _username_ - The specific user for which the follower(ing) list will be retrieved.
2. _startFollower(ing)_ - The starting letter(s) or name for the search query.
3. _followType_ - This value is set to `blog` and includes all users following or being followed by the `user`.
4. _limit_ - The maximum number of lines to be returned by the query.

A simple HTML interface is used to capture the required information after which the function is executed.

## Steps

1.  [**Configure connection**](#connection) Configuration of `dsteem` to communicate with the Steem blockchain
2.  [**Input variables**](#input) Collecting the required inputs via an HTML UI
3.  [**Get followers/following**](#query) Get the followers or users being followed
4.  [**Display**](#display) Display the array of results on the UI

#### 1. Configure connection<a name="connection"></a>

As usual, we have a `public/app.js` file which holds the Javascript segment of the tutorial. In the first few lines we define the configured library and packages:

```javascript
const dsteem = require('dsteem');
let opts = {};
//define network parameters
opts.addressPrefix = 'STM';
opts.chainId =
    '0000000000000000000000000000000000000000000000000000000000000000';
//connect to a steem node, production in this case
const client = new dsteem.Client('https://api.steemit.com');
```

Above, we have `dsteem` pointing to the production network with the proper chainId, addressPrefix, and endpoint.

#### 2. Input variables<a name="input"></a>

The required parameters for the follow operation is recorded via an HTML UI that can be found in the `public/index.html` file. The values have been pre-populated for ease of use but are editable.

The parameter values are allocated as seen below once the user clicks on the "Get Followers" or "Get Following" button.
The two queries are very similar and run from two different functions activated from a button on the UI. The first line of both functions is used to clear the display before new information is queried.

```javascript
//Followers function
window.submitFollower = async () => {
    //clear list
    document.getElementById('followList').innerHTML = '';
    
    //get user name
    const username = document.getElementById('username').value;
    //get starting letters / word
    const startFollow = document.getElementById('startFollow').value;
    //get limit
    var limit = document.getElementById('limit').value;
```

#### 3. Get followers/following<a name="query"></a>

A list of followers or users being followed is called from the database with the `follow_api` available in the `SteemJS` library.

```javascript
//get list of followers
//getFollowers(following, startFollower, followType, limit)
    let followlist = await client.call('follow_api', 'get_followers', [
        username,
        startFollow,
        'blog',
        limit,
    ]);

    document.getElementById('followResultContainer').style.display = 'flex';
    document.getElementById('followResult').className = 'form-control-plaintext alert alert-success';
    document.getElementById('followResult').innerHTML = 'Followers';


//get list of authors you are following
//getFollowing(follower, startFollowing, followType, limit)
    let followlist = await client.call('follow_api', 'get_following', [
        username,
        startFollow,
        'blog',
        limit,
    ]);

    document.getElementById('followResultContainer').style.display = 'flex';
    document.getElementById('followResult').className = 'form-control-plaintext alert alert-success';
    document.getElementById('followResult').innerHTML = 'Following';
  
```

#### 4. Display<a name="display"></a>

The result returned from the query is an array of objects. The follower(ing) value from that array is displayed on both the UI and the console via a simple `forEach` array method.

```javascript
    followlist.forEach((newObj) => {
        name = newObj.follower;
        document.getElementById('followList').innerHTML += name + '<br>';
        console.log(name);
    });
```

### To run this tutorial

 1. clone this repo
 2. `cd tutorials/19_get_follower_and_following_list`
 3. `npm i`
 4. `npm run dev-server` or `npm run start`
 5. After a few moments, the server should be running at http://localhost:3000/

---
