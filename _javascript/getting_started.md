---
title: Getting Started
position: 1
---

Install

$ npm install steem --save
Browser

```javascript
<script src="./steem.min.js">
<script>
steem.api.getAccounts(['ned', 'dan'], function(err, response){
    console.log(err, response);
});
``` 