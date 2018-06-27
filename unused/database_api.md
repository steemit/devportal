---
title: Database API
position: 2
---

Subscription examples

~~~ javascript
steem.api.setSubscribeCallback(callback, clearFilter, function(err, result) {
  console.log(err, result);
});
~~~
{: title="Set Subscribe Callback"} 

~~~ javascript
steem.api.setPendingTransactionCallback(cb, function(err, result) {
  console.log(err, result);
});
~~~
{: title="Set Pending Transaction Callback"} 

~~~ javascript
steem.api.setBlockAppliedCallback(cb, function(err, result) {
  console.log(err, result);
});
~~~
{: title="Set Block Applied Callback"} 

~~~ javascript
steem.api.cancelAllSubscriptions(function(err, result) {
  console.log(err, result);
});
~~~
{: title="Cancel All Subscriptions"}         
