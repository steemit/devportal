---
title: Steem Testnet
position: 3
---

Steem blockchain is written in C++ and in order to modify source code you need some understanding of the C++ programming language. Each Steem node runs instance of software and in order to test your changes you will need to know how to install dependencies which can be found in [Steem repo](https://github.com/steemit/steem/blob/master/doc/building.md). Which means some knowledge of System administion is also required. 
There are multiple advantages of running Testnet, you can test your scripts or applications on Testnet without spamming live network and it allows you much more flexibility to try new things. Testnet also helps you to work on new features and possibly submit new or improved pull requests to official Steem github repository.

## Running Testnet

By following official [building steps](https://github.com/steemit/steem/blob/master/doc/building.md#build_steem_testnetoffon) and enabling `BUILD_STEEM_TESTNET` flag during compilation, you should be able to run Steem Testnet locally on your device and join official testnet. Docker can also be used to get started quickly. Compilation generates `steemd` executable which is main daemon for Steem network. Additional `cli_wallet` can also be compiled to test/connect to instance of `steemd` and request some data from network, but it is not necessary to run a node.

Official testnet requires some minimum hardware requirements depending on type of compiling flags that was enabled. Because it is a mirror of live network and private keys are same for accounts until snapshot time of testnet.

Joining/Running official testnet require around 10 GB for block log on SSD and 8 GB RAM. The CPU requirements are the same


Testnet has following parameters by default (as of this writing):

* Initial supple (250 billion) - `STEEM_INIT_SUPPLY 250,000,000,000`
* Max number of blocks to be produced - `TESTNET_BLOCK_LIMIT 3,000,000`
* Address prefix, prefix on public addresses - `STEEM_ADDRESS_PREFIX "TST"`
* Chain id name, used for chain id - `STEEM_CHAIN_ID_NAME "testnet"`
* Chain id, unique id hash of chain - `STEEM_CHAIN_ID (fc::sha256::hash(STEEM_CHAIN_ID_NAME))`
* Public key of genesis account - `STEEM_INIT_PUBLIC_KEY_STR `
* Account creation fee - `STEEM_MIN_ACCOUNT_CREATION_FEE 0`

There are number of other subtle changes but we don't need those right now.

#### Live testnet

* ChainID: `46d82ab7d8db682eb1959aed0ada039a6d49afa1602491f93dde9cac3e8e6c32`
* Address prefix: `TST`
* API node: `https://testnet.steemitdev.com`

Anyone can join Live testnet and start testing their node and applications, become witness, provide API (RPC) node for public.


## Custom Testnet

In order to create our custom testnet which separate from offical one, we need to modify few parameters mentioned in previous section.

In `steem/libraries/protocol/include/steem/protocol/config.hpp` file we can see first few lines dedicated to Testnet section, line starts with `#ifdef IS_TEST_NET`.

Let's say we want to create custom testnet with Initial supply of **1,000,000 STEEM**. We can change `STEEM_INIT_SUPPLY 1,000,000` and by changing `STEEM_CHAIN_ID_NAME "testnet"`, **testnet** to **mytestnet** we will automatically get unique Chain ID for our testnet. Address prefix can be something like **MTN** and of course, we need to change Public and private key to the genesis account. Note that genesis account will recieve all premined supply of 1,000,000 so you can setup script to fund any newly created accounts. Custom testnet won't require stronger hardware requirements to run. 

Minimum of 8GB RAM should be sufficient to run Custom testnet. Currently Steem only has Linux and Mac compiling guides to build. Testnet can either be hosted locally on machine or rented AWS or dedicated servers so one can start testing functionality and explore diffirent APIs, start developing.

One more crucial point to modify is to change number of witnesses required to accept hardforks for Custom testnet, by default it is set to 17, we can change it to **1** `STEEM_HARDFORK_REQUIRED_WITNESSES 1` so that only one instance of node would be sufficient and network will be still functional and fast.

Another thing to note is that, you can start new chain with all previous hardforks already accepted, by changing in `steem/blob/master/libraries/chain/database.cpp` file following function:
`void database::init_genesis( uint64_t init_supply )` inside `try` add this line:
`set_hardfork( 19, true );` this would mean that 19 hardforks are accepted by witnesses and new chain starts with all previous forks included.

After all these changes, all we have to do is compile source code and get steemd executable. And once we fire up custom testnet we can start testing and experimenting new things.

If you want to port some data from Steem main network you can use [Tinman](https://github.com/steemit/tinman) developed by Steemit to help with taking snapshots of main network.

#### Custom live testnet

* ChainID: `79276aea5d4877d9a25892eaa01b0adf019d3e5cb12a97478df3298ccdd01673`
* Address prefix: `STX`
* API node: `https://testnet.steem.vc`

Above testnet is powered by community member @almost-digital and doesn't have snapshot of main network. 
