---
title: Using jussi as a Multiplexer
position: 1
description: Optimize your local applications with jussi
exclude: true
layout: full
---

*By the end of this recipe you should know how to install `jussi` on your local subnet to take advantage of its features.*

This recipe will take you through the process of setting up `jussi` for a small infrastructure like a home network.

## Intro 

What is a Multiplexer?  In this context, a multiplexer an appliance that accepts API requests from multiple applications running on the same subnet and passes them to an upstream node.  This means, for example, if you have two applications that request the same block from API, your local `jussi` instance will make a single upstream request for the block and return it to both applications.

Deploying `jussi` on your own local subnet will help improve efficiency because your local applications won't require SSL and `jussi` can take care of gzipping requests that go out over the Internet.

<center>
  <img src="/images/tutorials-recipes/jussi-multiplexer/network-diagram.png" alt="Network Diagram" />
</center>
  
## Steps

1. [**Setting Up Docker**](#setting-up-docker) In order to run `jussi`, `docker` is recommended
1. [**Install `jussi`**](#install-jussi) Clone `jussi` from the repository and build
1. [**Configure Your Apps**](#configure-your-apps) Point all of your applications to this node

#### 1. Setting Up Docker <a name="setting-up-docker"></a>

Although it's possible to set up `jussi` to run natively without virtualization, `docker` is recommended.  Setting up `docker` depends on your operating system:

* [Docker for Linux](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce)
* [Docker for macOS](https://docs.docker.com/docker-for-mac/install/)
* [Docker for Windows](https://docs.docker.com/docker-for-windows/)

#### 2. Install `jussi` <a name="install-jussi"></a>

```bash
git clone https://github.com/steemit/jussi.git
cd jussi
```

Edit the file `DEV_config.json` and change all:

`https://steemd.steemitdev.com`

... to ...

`https://api.steemit.com`

Then build and run:

```bash
docker build -t="$USER/jussi:$(git rev-parse --abbrev-ref HEAD)" .
docker run -itp 9000:8080 "$USER/jussi:$(git rev-parse --abbrev-ref HEAD)"
```

#### 3. Configure Your Apps <a name="configure-your-apps"></a>

Now, you can use your new `jussi` node as if it's a full node running locally.  For example:

```bash
curl -s --data '{"jsonrpc":"2.0", "method":"condenser_api.get_block", "params":[8675309], "id":1}' http://localhost:9000
```

In this case, `http://localhost:9000` will act like a full node.  In reality, it's passing all of its request to its upstream, `https://api.steemit.com`.

Once you've implemented your own `jussi` node in this manner, you should notice an improvement in bandwidth utilization.  If you're internet provider implements packet shaping strategies, this will have a positive impact because you are no longer streaming the entire blockchain once for each application.

## Troubleshooting / Updating

#### Error: `invalid argument "/jussi:master" for t=/jussi:master: invalid reference format`

*Solution:*

You're probably trying to run on a raspberry pi.  Just replace `$USER` in the command with the current user.

---

If you would like to update `jussi` to the latest version, here's a quick way:

```bash
git stash && git pull && git stash pop
```

If there are `git` errors due to structural changes to `DEV_config.json`, just start over from step 2 and reclone `jussi` to a fresh location.  Otherwise, you should be able to rebuild and run.
