---
title: SteemConnect
position: 3
description: Tutorial is about Authorization on Steem and usage of SteemConnect
layout: full
right_code: |
    <p class="static-right-section-title">Install</p>
    ```
    npm i sc2-sdk
    ```
    <p class="static-right-section-title">Initialize</p>
    ``` javascript
    const sc2 = require('sc2-sdk');
    let api = sc2.Initialize({
        app: 'demo-app',
        callbackURL: 'http://localhost:3000',
        scope: ['vote','comment']
    })
    ```
    <p class="static-right-section-title">Login URL</p>
    ``` javascript
    let link = sc2.getLoginURL()
    ```
    <p class="static-right-section-title">Request link</p>
    ``` object
    link = https://v2.steemconnect.com/oauth2/authorize?client_id=demo-app&redirect_uri=http://localhost:3000&scope=vote,comment
    ```
    <p class="static-right-section-title">Result auth</p>
    ```
    http://localhost:3000/auth?access_token=xyz&expires_in=604800&username=demo
    access_token: xyz
    expires_in: 604800
    username: demo
    ```
    <p class="static-right-section-title">Set token</p>
    ``` javascript
    sc2.setAccessToken(access_token)
    ```
    <p class="static-right-section-title">Get User info</p>
    ``` javascript
    api.me(function(err,res){
        //json object with user info
        console.log(err,res);
    });
    ```
    ``` object
    account: {id:xxx, name:'demo', owner:{}, active:{},...}
    name: 'demo',
    scope: ['vote'],
    user: 'demo',
    user_metadata: {},
    ```
    <p class="static-right-section-title">Logout</p>
    ``` javascript
    api.revokeToken(function(err, res){
        console.log(err, res);
    })
    ```
---
## Goal

The application in this tutorial asks the user to grant access to `demo-app` and get a token from Steemconnect. Once permission is granted, `demo-app` can get details of the user via an api call that requires an access token. 
The purpose of this is to allow any application to request permission from user and perform action via the access token.

Some other calls that require an access token (or login) are:

* Vote
* Comment
* Post
* Follow
* Reblog

Learn more about [Steemconnect operations here](https://github.com/steemit/steemconnect-sdk)

## Overview

Steemconnect is unified authentification system built on top of Steem and is built in a collaboration of Busy.org and Steemit Inc.
Steemconnect is a layer to ensure easy access and setup for all application developers as well as a secure way for users to interact with Steem apps.

Setting up Steemconnect in your app is straight-forward process and never been this easy.

- This tutorial is available at [Devportal tutorials repo](https://github.com/steemit/devportal-tutorials-js)
- The specific Steemconnect tutorial is found here [Steemconnect tutorial](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/02_steemconnect)

## Step I

1. Visit [Steemconnect Dashboard](https://steemconnect.com/dashboard) and login with your Steem credentials

![steemconnect_login](https://steemitimages.com/DQmRpjPgR3BTtFCrL553AxZ6CDswPRdbNAAo9CMRxoCdBZV/Screen%20Shot%202018-03-20%20at%2012.31.37.png)

2. You will see an Applications and Developers section, in Developers section click on `My Apps`

![steemconnect_dashboard](https://steemitimages.com/DQmZub5Tt8ZuqpDqYYFCP89ypjeFbePWd63Gud9pouSA34S/Screen%20Shot%202018-03-20%20at%2012.31.58.png)

![steemconnect_new_app](https://steemitimages.com/DQmaShy9S6wRMzUMfiULebdB7KsrdTpQn4HNgaWtfFyVL3E/Screen%20Shot%202018-03-20%20at%2012.32.15.png)

3. Create a New App using Steemconnect, which will help you create new Steem account for your application. Let's call it `demo-app` for this tutorial purpose.

![steemconnect_account_create](https://steemitimages.com/DQmcQvuYJ5wo9xwxmYUHtCkvazfhLHEjwKi8GaNGyZnNSQh/Screen%20Shot%202018-03-20%20at%2012.32.28.png)

An account creation fee will be deducted from your balance, make sure you have enough funds to complete the account creation. Next step is to login with the account which has enough STEEM to pay for the account creation fee.

![](https://steemitimages.com/DQmUtrbpujdNRft5hdEgzMPbGZfgLvXJyRZH9WzKfAWp93p/Screen%20Shot%202018-03-20%20at%2012.32.57.png)

4. Give your app name, description, icon image link, website (if available) and Redirect URI(s)

![steemconnect_myapps](https://steemitimages.com/DQmYkbHUFC6iorEJv6iCC2CB6oG1TigEE9SxuQrZAkTEYJW/FireShot%20Capture%206%20-%20SteemConnect%20-%20https___v2.steemconnect.com_apps_%40demo-app_edit.png)

Redirect URI(s) will be used within your application to forward user after authentication is successful. This is typical backend web development, we hope you know how to set this up.

* Disclaimer: All images/screenshots of user interface may change as Steemconnect evolves

## Step II

Once you have setup your account for the new application, you can setup your application with Steemconnect authentification and API processes.

### Install
To do that, you will need to install `sc2-sdk` nodejs package with `npm i sc2-sdk`.
Within the application you can initialize Steemconnect

### Initialize
> `app` - is the account name for the application that we have created in Step I.3, `callbackURL` - is the Redirect URI that we have defined in Step I.4, `scope` - permissions application is requiring/asking from users


Now that `sc2-sdk` is initialized we can start authentication and perform simple operations with Steemconnect.

### Login URL

> Returns login URL which will redirect the user to sign in with Steemconnect login screen. A successful login will redirect the user to the Redirect URI or `callbackURL`. The result of the successful login will return an `access_token`, `expires_in` and `username` information, which the application will start utilizing.

### Request link

> Your application can request the link which can be used in a popup screen or relevant screen you develop. The popup screen will ask the user to identify themselves using their username and password. Once they have authenticated successfully the authentication result will be returned

### Result auth

> The returned json object will have the following properties

``` javascript
result = {
    "access_token": "xyz", // used for future API calls
    "expires_in": 604800, // how long the access token will be valid for (in seconds) and how long the user will be logged in for
    "username": "demo" // current username that is authenticated
}
```

### Set token

> After getting the `access_token`, we can set token for future Steemconnect API requests.

### Get user info

> Users info can be checked with `me` which will return object

``` javascript
result = {
    account: {id:xxx, name:'demo', owner:{}, active:{},...} // current state of account and the details as stored on the Steem blockchain
    name: 'demo', // the logged in username
    scope: ['vote'], // the permissions that are allowed for the logged in user
    user: 'demo', // the current username
    user_metadata: {} // additional information user has setup.
}
```
### Logout

> In order to logout, you can use the `revokeToken` function from `sc2-sdk`.

## Source code [<img src="/images/look.svg" width="16" height="16" />](getting-started#setup_node_js)

To try this application visit [Devportal tutorials repo](https://github.com/steemit/devportal-tutorials-js), find [Steemconnect tutorial](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/02_steemconnect) and follow **To run** section in README.


