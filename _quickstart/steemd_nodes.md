---
title: steemd Nodes
position: 2
right_code: |
    ``` bash
    docker run \
        -d -p 2001:2001 -p 8090:8090 --name steemd-default \
        steemit/steem
    
    docker logs -f steemd-default  # follow along
    ``` 
    ``` bash
    docker run \
        --env USE_WAY_TOO_MUCH_RAM=1 \
        -d -p 2001:2001 -p 8090:8090 --name steemd-full \
        steemit/steem
    
    docker logs -f steemd-full
    ```  
---

Applications that interface directly with the Steem blockchain will need to connect to a steemd node. Developers may choose to use one of the public API nodes that are available, or run their own instance of a node.

### Public Nodes

|URL|Owner|
|---|---|
|gtg.steem.house:8090|@gtg|
|steemd.minnowsupportproject.org|@followbtcnews|
|steemd.privex.io|@privex|
|steemd.steemgigs.org|@steemgigs|
|steemd.steemit.com|@steemit|
|rpc.steemliberator.com|@netuoso|
|rpc.steemviz.com|@ausbitbank|

### Private Nodes

The simplest way to get started is by deploying a prebuilt dockerized container. 
 
##### Dockerized p2p Node
*To run a p2p node (ca. 2GB of memory is required at the moment):*

##### Dockerized Full Node
*to run a node with all the data (e.g. for supporting a content website) that uses ca. 14GB of memory and growing:*
