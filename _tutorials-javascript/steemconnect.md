---
title: SteemConnect
position: 2
description: Tutorial is about Authorization on Steem and usage of SteemConnect
layout: full
right_code: |

    Install
    ```
    npm i sc2-sdk
    ```

    Initialize
    ``` javascript
    const sc2 = require('sc2-sdk');
    let api = sc2.Initialize({
        app: 'demo-app',
        callbackURL: 'http://localhost:3000',
        scope: ['vote','comment']
    })
    ```

    Login URL
    ``` javascript
    let link = sc2.getLoginURL()
    ```

    Request link
    ``` object
    link = https://v2.steemconnect.com/oauth2/authorize?client_id=demo-app&redirect_uri=http://localhost:3000&scope=vote,comment
    ```

    Result
    ```
    http://localhost:3000/auth?access_token=xyz&expires_in=604800&username=demo

    access_token: xyz
    expires_in: 604800
    username: demo
    ```

    Set token
    ``` javascript
    sc2.setAccessToken(access_token)
    ```

    Get User info
    ``` javascript
    api.me(function(err,res){
        //json object with user info
        console.log(err,res);
    });
    ```

    Result
    ``` object
    account: {id:xxx, name:'demo', owner:{}, active:{},...}
    name: 'demo',
    scope: ['vote'],
    user: 'demo',
    user_metadata: {},
    ```

    Logout
    ``` javascript
    api.revokeToken(function(err, res){
        console.log(err, res);
    })
    ```
---
### Goal

The application in this tutorial asks the user to grant an access to `demo-app` and get token from Steemconnect. Once permission is granted, `demo-app` can get details of user via an api call that requires access token. 
Purpose is to allow any application request permission from user and perform action via access token.

Some other calls that require an access token (or login) are:

* Vote
* Comment
* Post
* Follow
* Reblog

Learn more about [Steemconnect operations here](https://github.com/steemit/steemconnect-sdk)

### Overview

Steemconnect is unified authentification system built on top of Steem built in collaboration of Busy.org and Steemit Inc.
Layer to ensure easy access and setup for all application developers as well as secure way for users to interact with Steem apps.

Setting up Steemconnect in your app is straight-forward process and never been this easy.

### Step I

1. Visit [Steemconnect Dashboard](https://steemconnect.com/dashboard) and login with your Steem credentials

![steemconnect_login](https://steemitimages.com/DQmRpjPgR3BTtFCrL553AxZ6CDswPRdbNAAo9CMRxoCdBZV/Screen%20Shot%202018-03-20%20at%2012.31.37.png)

2. You will see Applications and Developers section, in Developers section click on `My Apps`

![steemconnect_dashboard](https://steemitimages.com/DQmZub5Tt8ZuqpDqYYFCP89ypjeFbePWd63Gud9pouSA34S/Screen%20Shot%202018-03-20%20at%2012.31.58.png)

![steemconnect_new_app](https://steemitimages.com/DQmaShy9S6wRMzUMfiULebdB7KsrdTpQn4HNgaWtfFyVL3E/Screen%20Shot%202018-03-20%20at%2012.32.15.png)

3. Create New App using Steemconnect, which will help you create new Steem account for your application. Let's call it `demo-app` for this tutorial purpose.

![steemconnect_account_create](https://steemitimages.com/DQmcQvuYJ5wo9xwxmYUHtCkvazfhLHEjwKi8GaNGyZnNSQh/Screen%20Shot%202018-03-20%20at%2012.32.28.png)

Account creation fee will be deducted from your balance, make sure you have enough funds to complete account creation. Next step is to login with account which has enough balance to pay for account creation fee.

![](https://steemitimages.com/DQmUtrbpujdNRft5hdEgzMPbGZfgLvXJyRZH9WzKfAWp93p/Screen%20Shot%202018-03-20%20at%2012.32.57.png)

4. Give your app name, description, icon image link, website (if available) and Redirect URI(s)

![steemconnect_myapps](https://steemitimages.com/DQmYkbHUFC6iorEJv6iCC2CB6oG1TigEE9SxuQrZAkTEYJW/FireShot%20Capture%206%20-%20SteemConnect%20-%20https___v2.steemconnect.com_apps_%40demo-app_edit.png)

Redirect URI(s) will be used within your application to forward user after authentification is successful. This is typical backend web development, we hope you know how to set up.

* Disclaimer: All images/screenshots of user interface may change as Steemconnect evolves

### Step II

Once you have setup account for new application, you can setup application with Steemconnect authentification and API processes.
To do that, you will need to install `sc2-sdk` nodejs package with `npm i sc2-sdk`.
Within application you can initialize Steemconnect

##### Initialize
> `app` - is account name for application that we have created in Step I.3, `callbackURL` - is Redirect URI that we have defined in Step I.4, `scope` - permissions application is requiring/asking from users


Now that `sc2-sdk` is initialized we can start authentication and perform simple operations with Steemconnect.

##### Login URL

> Returns login URL which will redirect user to sign in with Steem connect screen. Successfull login will redirect user to Redirect URI or `callbackURL`. Result of successful login will return `access_token`, `expires_in` and `username` information, which application will start utilizing.

##### Request link

> Application can request returned link into popup screen or relevant screen you have developed. Popup screen will ask user to identify themselves with their username and password. Once login is successful, you will have Results

##### Result

> Returned data has `access_token` - which will be used in future api calls, `expires_in` - how long  access token is valid in seconds and `username` of logged in user.

##### Set token

> After getting `access_token`, we can set token for future Steemconnect API requests.

##### Get user info

> Users info can be checked with `me` which will return object
`account` - current state of account and its details on Steem blockchain, `name` - username, `scope` - permissions allowed with current login, `user` - username, `user_metadata` - additional information user has setup.

##### Logout

> In order to logout, you can use `revokeToken` function from sc2-sdk.

### Source code

To try this application visit [Devportal tutorials repo](https://github.com/steemit/devportal-tutorials-js), find [Steemconnect tutorial](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/02_steemconnect) and follow **To run** section in README.


