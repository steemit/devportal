---
title: Docker
position: 1
---

Just want to get up and running quickly? Try deploying a prebuilt dockerized container. Both common binary types are included.

Just want to get up and running quickly?  Try deploying a prebuilt
dockerized container.  Both common binary types are included.

#### Dockerized p2p Node

To run a p2p node (ca. 2GB of memory is required at the moment):

    docker run \
        -d -p 2001:2001 -p 8090:8090 --name steemd-default \
        steemit/steem

    docker logs -f steemd-default  # follow along

#### Dockerized Full Node

To run a node with *all* the data (e.g. for supporting a content website)
that uses ca. 14GB of memory and growing:

    docker run \
        --env USE_WAY_TOO_MUCH_RAM=1 \
        -d -p 2001:2001 -p 8090:8090 --name steemd-full \
        steemit/steem

    docker logs -f steemd-full

#### Seed Nodes

A list of some seed nodes to get you started can be found in
[doc/seednodes.txt](doc/seednodes.txt).

This same file is baked into the docker images and can be overridden by
setting `STEEMD_SEED_NODES` in the container environment at `docker run`
time to a whitespace delimited list of seed nodes (with port).