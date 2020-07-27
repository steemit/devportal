---
title: 'JS: Steemlogin'
position: 2
description: "_Understand the basics of using Steemlogin with your Steem application._"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Steemlogin](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/02_steemlogin) can be downloaded as part of the [JS tutorials repository](https://github.com/steemit/devportal-tutorials-js).</span>
<br>



In this tutorial we will setup Steemlogin for demo application and step by step show the process of setting up dedicated account for your app to use Steemlogin Dashboard and setup backend of your application to use Steemlogin authorization properly.

## Intro

The application in this tutorial asks the user to grant an access to `demo-app` and get token from Steemlogin. Once permission is granted, `demo-app` can get details of user via an api call that requires access token.
Purpose is to allow any application request permission from user and perform action via access token.

Some other calls that require an access token (or login) are:

*   Vote
*   Comment
*   Post
*   Follow
*   Reblog

Learn more about [Steemlogin operations here](https://github.com/steemit/steemlogin-sdk)

## Steps

1.  [**Steemlogin Dashboard**](#sc-dashboard) Create account for application and set up dashboard
1.  [**Initialize Steemlogin**](#init-sc) Initialize SDK in your application code
1.  [**Login URL**](#login-url) Form login url for user
1.  [**Request token**](#request-token) Request token with login url
1.  [**Set token**](#set-token) Set or save token for future requests
1.  [**Get user data**](#get-user) Get user details with token
1.  [**Logout**](#logout) Logout user and clear token

#### 1. Steemlogin Dashboard<a name="sc-dashboard"></a>

Steemlogin is unified authentification system built on top of Steem built in collaboration of Busy.org and Steemit Inc.
Layer to ensure easy access and setup for all application developers as well as secure way for users to interact with Steem apps.

Setting up Steemlogin in your app is straight-forward process and never been this easy.

Here are the steps that helps you to setup new app:

1a. Visit [Steemlogin Dashboard](https://steemlogin.com/dashboard) and login with your Steem credentials

![steemlogin_login](https://github.com/steemit/devportal-tutorials-js/blob/master/tutorials/02_steemlogin/images/steemlogin_login.png?raw=true)

1b. You will see Applications and Developers section, in Developers section click on `My Apps`

![steemlogin_dashboard](https://github.com/steemit/devportal-tutorials-js/blob/master/tutorials/02_steemlogin/images/steemlogin_dashboard.png?raw=true)

![steemlogin_new_app](https://github.com/steemit/devportal-tutorials-js/blob/master/tutorials/02_steemlogin/images/steemlogin_new_app.png?raw=true)

1c. Create New App using Steemlogin, which will help you create new Steem account for your application. Let's call it `demo-app` for this tutorial purpose.

![steemlogin_account_create](https://github.com/steemit/devportal-tutorials-js/blob/master/tutorials/02_steemlogin/images/steemlogin_account_create.png?raw=true)

Account creation fee will be deducted from your balance, make sure you have enough funds to complete account creation.

Next step is to login with account which has enough balance to pay for account creation fee.

![steemlogin_signin](https://github.com/steemit/devportal-tutorials-js/blob/master/tutorials/02_steemlogin/images/steemlogin_signin.png?raw=true)

1d. Give your app name, description, icon image link, website (if available) and Redirect URI(s)

![steemlogin_myapps](https://github.com/steemit/devportal-tutorials-js/blob/master/tutorials/02_steemlogin/images/steemlogin_myapps.png?raw=true)

Application name and description should give users clear understanding what permissions it requires and what is the purpose of the app.

App Icon field should be publicly accessible and available link to your logo or icon.

Website field is homepage for the application if exist.

Redirect URI(s) will be used within your application to forward user after authentification is successful. You can specify multiple callback URLs with each new line. Callback in Steemlogin SDK should match exactly one of URI(s) specified on this page. Due to security reasons if redirect URI(s) used in SDK is other than you specified, it will not work.
This is typical backend web development, we hope you know how to set up your backend/app to handle callback URLs.

*   Disclaimer: All images/screenshots of user interface may change as Steemlogin evolves

#### 2. Initialize Steemlogin<a name="init-sc"></a>

Once you have setup account for new application, you can setup application with Steemlogin authentification and API processes.
To do that, you will need to install `sc2-sdk` nodejs package with `npm i sc2-sdk`.
Within application you can initialize Steemlogin

> `app` - is account name for application that we have created in Step I.3, `callbackURL` - is Redirect URI that we have defined in Step I.4, `scope` - permissions application is requiring/asking from users

Now that `sc2-sdk` is initialized we can start authentication and perform simple operations with Steemlogin.

#### 3. Login URL<a name="login-url"></a>

> `getLoginURL` function you see on the right side, returns login URL which will redirect user to sign in with Steem connect screen. Successfull login will redirect user to Redirect URI or `callbackURL`. Result of successful login will return `access_token`, `expires_in` and `username` information, which application will start utilizing.

#### 4. Request token<a name="request-token"></a>

> Application can request returned link into popup screen or relevant screen you have developed. Popup screen will ask user to identify themselves with their username and password. Once login is successful, you will have Results

#### 5. Set token<a name="set-token"></a>

> Returned data has `access_token` - which will be used in future api calls, `expires_in` - how long access token is valid in seconds and `username` of logged in user.

> After getting `access_token`, we can set token for future Steemlogin API requests.

#### 6. Get user data<a name="get-user"></a>

> Users info can be checked with `me` which will return object
> `account` - current state of account and its details on Steem blockchain, `name` - username, `scope` - permissions allowed with current login, `user` - username, `user_metadata` - additional information user has setup.

#### 7. Logout<a name="logout"></a>

> In order to logout, you can use `revokeToken` function from sc2-sdk.

**That's all there is to it.**

### To Run the tutorial

1.  clone this repo
1.  `cd tutorials/02_steemlogin`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)


---
