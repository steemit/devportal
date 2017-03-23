---
title: steemd
position: 3
---

##### **steemd**

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