---
title: Steem Testnet
position: 3
exclude: true
---

Steem blockchain software is written in C++ and in order to modify the source code you need some understanding of the C++ programming language. Each Steem node runs an instance of this software, so in order to test your changes, you will need to know how to install dependencies which can be found in the [Steem repo](https://github.com/steemit/steem/blob/master/doc/building.md). This also means that some knowledge of System administration is also required. There are multiple advantages of running a testnet, you can test your scripts or applications on a testnet without extra spam on the live network, which allows much more flexibility to try new things. Having access to a testnet also helps you to work on new features and possibly submit new or improved pull requests to official the Steem GitHub repository.

## Steemit's Testnet

Steemit maintains a live testnet to which you can connect. In the near future, we expect the chain id to update with every code change. To get the current chain id for any HF20+ Steem testnet you can use the [database_api.get_version](/apidefinitions/#database_api.get_version) api call (curl example included for your convenience). Be sure to point it at an api node on the testnet for which you want information!


### Features

The official Steemit, Inc. Testnet is a mirror of the mainnet.  This is achieved by copying the existing accounts and transactions from the mainnet state, as the they happen.  Accounts are copied from a [snapshot](https://github.com/steemit/tinman#taking-a-snapshot) of mainnet while the module used to copy transactions in real time is called [`gatling`](https://github.com/steemit/tinman#gatling-transactions-from-mainnet).  The `gatling` module runs at the final step of each testnet deployment.

The combination of `snapshot` and `gatling` means that this testnet approaches a subset of the same activity that the mainnet experiences.  Not everything can be mirrored.  For example, if someone comments or votes on a post that hasn't been mirrored to the testnet (because the post itself pre-dates the testnet deploy), those operations will also not be included.

At the time of this writing, the connection information for Steemit's testnet is as follows: 
 
* ChainID: `46d82ab7d8db682eb1959aed0ada039a6d49afa1602491f93dde9cac3e8e6c32`
* Address prefix: `TST`
* API node: `https://testnet.steemitdev.com`

## Running a Testnet Node

First, let's build `steemd` specifically for testnet.  Recommended specs:

* `Ubuntu Server 16.04 LTS`
* `100GB HDD`
* `16GB RAM` (mostly needed for `steemd` build)

```bash
sudo apt-get update && sudo apt-get dist-upgrade
sudo reboot

sudo apt-get install autoconf automake autotools-dev bsdmainutils build-essential cmake doxygen \
   git libboost-all-dev libreadline-dev libssl-dev libtool ncurses-dev pbzip2 pkg-config \
   python3-dev python3-jinja2 python3-pip libbz2-dev libsnappy-dev\
   wget curl screen pv virtualenv nano xz-utils
mkdir -p src
cd src
git clone https://github.com/steemit/steem
cd steem
git checkout <20180824-testnet OR develop OR a more current branch>
git submodule update --init --recursive
mkdir -p build
cd build
cmake \
   -DCMAKE_BUILD_TYPE=Release \
   -DBUILD_STEEM_TESTNET=ON \
   -DENABLE_SMT_SUPPORT=ON \
   -DLOW_MEMORY_NODE=ON \
   -DCHAINBASE_CHECK_LOCKING=ON \
   -DCLEAR_VOTES=ON \
   -DSKIP_BY_TX_ID=ON \
   -DSTEEM_LINT_LEVEL=OFF \
   ..
make -j$(nproc) install
cd
mkdir -p testnet-data
cd testnet-data
nano config.ini
```

### `config.ini`

```ini
log-console-appender = {"appender":"stderr","stream":"std_error"}
log-file-appender = {"appender":"p2p","file":"logs/p2p/p2p.log"}
log-logger = {"name":"default","level":"info","appender":"stderr"}
log-logger = {"name":"p2p","level":"warn","appender":"p2p"}

backtrace = yes
plugin = chain p2p webserver witness database_api network_broadcast_api block_api 

shared-file-dir = "blockchain"
shared-file-size = 12G
p2p-endpoint = 0.0.0.0:2001
webserver-http-endpoint = 0.0.0.0:8751
webserver-ws-endpoint = 0.0.0.0:8752

# testnet.steemitdev.com
p2p-seed-node = testnet.steemitdev.com:2001
```

Then execute:

```bash
steemd --data-dir=. --chain-id=46d82ab7d8db682eb1959aed0ada039a6d49afa1602491f93dde9cac3e8e6c32
```

Now let it sync, and you'll have a shiny new testnet seed node to play with.

## Custom Testnet

In order to create a custom, isolated, testnet separate from the Steemit's we need to modify a few things mentioned in the previous section.

In the file named `steem/libraries/protocol/include/steem/protocol/config.hpp`, we can see the first few lines dedicated to the Testnet section. The line starts with `#ifdef IS_TEST_NET`.

Let's say we want to create a custom testnet with an initial supply of **1,000,000 STEEM**. We can change `STEEM_INIT_SUPPLY 1,000,000` and by changing `STEEM_CHAIN_ID_NAME "testnet"`, **testnet** to **mytestnet** we will automatically get a unique Chain ID for our testnet. The address prefix can be set to something like **MTN** and of course, we need to change the public and private keys to the genesis account. Note that the genesis account will receive the entire pre-mined supply of 1,000,000. That way, you can execute a setup script to fund any newly created accounts. Such a custom testnet will not have any additional hardware requirements to run.

A minimum of 8GB RAM should be sufficient to run a custom testnet. Currently, Steem only has Linux and Mac compiling guides to build. A testnet can either be hosted locally, on a rented AWS, or dedicated bare metal servers so one can start testing functionality, explore different APIs, and start developing.

One more crucial point to modify is to change the number of witnesses required to accept hardforks for a custom testnet, by default it is set to 17, we can change it to **1** `STEEM_HARDFORK_REQUIRED_WITNESSES 1` so that only one node instance would be sufficient and the network will be still functional and fast.

Another thing to note is that you can start a new chain with all previous hardforks already accepted, by changing the file named `steem/blob/master/libraries/chain/database.cpp` with the following function:

`void database::init_genesis( uint64_t init_supply )` inside `try` add this line:

`set_hardfork( 19, true );`

This would mean that 19 hardforks have been accepted by witnesses and the new chain will start with all previous forks included.

After these changes, all we have to do is compile the source code and get the `steemd` executable. And once we fire up the custom testnet we can start testing and experimenting.

If you want to port some data from Steem main network you can use [Tinman](https://github.com/steemit/tinman), also developed by Steemit, to help with taking snapshots of the main network.

#### Custom live testnet

An example of a custom testnet run by Steem community member [@almost-digital](https://steemit.com/@almost-digital). It doesn't have a snapshot of the main network

*   ChainID: `79276aea5d4877d9a25892eaa01b0adf019d3e5cb12a97478df3298ccdd01673`
*   Address prefix: `STX`
*   API node: `https://testnet.steem.vc`
