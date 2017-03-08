---
title: Choose Library
position: 1
right_code: |
    ~~~ python
    from steem.account import Account
    account = Account("xeroc")
    print(account)
    print(account.reputation())
    print(account.balances)
    ~~~
    {: title="Accounts"}
---

Getting started with the steem blockchain couldn't be easier.  

#### Javascript developers

Our official JS toolkit is located at : [https://github.com/steemit/steem-js](https://github.com/steemit/steem-js)

Documentation to get going is located in the [Javascript Section](#javascriptgetting_started).

#### Steemd

The simplest way to get started is by deploying a prebuilt dockerized container. 
 
##### Dockerized p2p Node
*To run a p2p node (ca. 2GB of memory is required at the moment):*
```
docker run \
    -d -p 2001:2001 -p 8090:8090 --name steemd-default \
    steemit/steem

docker logs -f steemd-default  # follow along
```

##### Dockerized Full Node
*to run a node with all the data (e.g. for supporting a content website) that uses ca. 14GB of memory and growing:*
```
docker run \
    --env USE_WAY_TOO_MUCH_RAM=1 \
    -d -p 2001:2001 -p 8090:8090 --name steemd-full \
    steemit/steem

docker logs -f steemd-full
```