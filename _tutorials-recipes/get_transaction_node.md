---
title: Get Transaction Node
position: 1
description: |
  Setting up a node that supports `*.get_transaction`.
exclude: true
layout: full
---

### Intro

This tutorial will show how to setup the lowest possible resource node that can support `condenser_api.get_transaction` and `account_history_api.get_transaction`.

### Sections

* [Minimum Requirements](#minimum-requirements)
* [Building `steemd`](#building-steemd)
* [Configure Node](#configure-node)
* [Latest Block Log](#latest-block-log)
* [Sync Node](#sync-node)
* [Troubleshooting](#troubleshooting)

### Minimum Requirements

This tutorial assumes Ubuntu Server 18.04 LTS 16GB RAM and 320GB SSD/HDD.

### Building `steemd`

```bash
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install autoconf automake autotools-dev bsdmainutils \
  build-essential cmake doxygen gdb libboost-all-dev libreadline-dev \
  libssl-dev libtool liblz4-tool ncurses-dev pkg-config python3-dev \
  python3-pip nginx fcgiwrap awscli gdb libgflags-dev libsnappy-dev zlib1g-dev \
  libbz2-dev liblz4-dev libzstd-dev
mkdir -p ~/src
cd ~/src
git clone --branch stable https://github.com/steemit/steem.git
cd steem
git submodule update --init --recursive
mkdir -p build
cd build
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DLOW_MEMORY_NODE=ON \
  -DCLEAR_VOTES=ON \
  -DSKIP_BY_TX_ID=OFF \
  -DSTEEM_LINT_LEVEL=OFF \
  -DENABLE_MIRA=OFF \
  ..
make -j$(nproc)
sudo make install
```

### Configure Node

```bash
mkdir -p ~/steem_data
cd ~/steem_data
steemd --data-dir=.
```

At the startup banner, press `^C` (Ctrl+C) to exit `steemd`.  As a side effect, a default data-dir is created.  Now we can purge the empty blockchain and create `config.ini` as follows:

```bash
rm -Rf blockchain
nano config.ini
```

Then make the following changes to the generated `config.ini`:

* Enable plugins: `p2p webserver account_history block_api condenser_api database_api account_history_api`
* Blacklist all virtual operations from account history.
* Pick a port for p2p to `2000`.
* Edit `shared-file-size` to `54G`.
* Pick a port for `webserver-http-endpoint` and set `webserver-ws-endpoint` to the next-highest port.

To summarize, the *changed* values are:

```ini
plugin = p2p webserver account_history block_api condenser_api database_api account_history_api
account-history-blacklist-ops = fill_convert_request_operation author_reward_operation curation_reward_operation comment_reward_operation liquidity_reward_operation interest_operation fill_vesting_withdraw_operation fill_order_operation shutdown_witness_operation fill_transfer_from_savings_operation hardfork_operation comment_payout_update_operation return_vesting_delegation_operation comment_benefactor_reward_operation producer_reward_operation clear_null_account_balance_operation proposal_pay_operation sps_fund_operation
shared-file-size = 54G
p2p-endpoint = 0.0.0.0:2000
webserver-http-endpoint = 0.0.0.0:8751
webserver-ws-endpoint = 0.0.0.0:8752
```

Save `config.ini`.

#### Latest Block Log

Download the block log (optional but recommended).

```bash
cd ~/steem_data
mkdir -p blockchain
wget -O blockchain/block_log https://s3.amazonaws.com/steemit-dev-blockchainstate/block_log-latest
steemd --data-dir=. --replay-blockchain
```

### Sync Node

If you did not download the latest block log:

```bash
cd ~/steem_data
steemd --data-dir=. --resync-blockchain
```

After *replay* or *resync* is complete, the console will display `Got ## transactions from  ...`.  It's possible to close `steemd` with `^C` (Ctrl+C).  Then, to start the node again:

```bash
cd ~/steem_data
steemd --data-dir=.
```

### Troubleshooting<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

**Problem:** Got an error while trying to compile `steemd`:

`c++: internal compiler error: Killed (program cc1plus)`

**Solution:** Add more memory or enable swap.

To enable swap (do not enable swap on a VPS like Digital Ocean):

```bash
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=4000
sudo chmod 600 /var/swap.img
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
```

---

**Problem:** Got an error while replaying:

`IO error: While open a file for appending: /root/steem_data/./blockchain/rocksdb_witness_object/012590.sst: Too many open files`

**Solution:** You're using MIRA, but this tutorial recommends *not* to (`-DENABLE_MIRA=OFF`).  If you really *intend* to try MIRA, you will need to set higher limits.  Note, if you are also running `steemd` as `root` (not recommended), you must explicitly set hard/soft nofile/nproc lines for `root` instead of `*` in `/etc/security/limits.conf`.

To set the open file limit ...

```bash
sudo nano /etc/security/limits.conf
```

Add the following lines:

```conf
*      hard    nofile     94000
*      soft    nofile     94000
*      hard    nproc      64000
*      soft    nproc      64000
```

To set the `fs.file-max` limit ...

```bash
sudo nano /etc/sysctl.conf
```

Add the following line:

```ini
fs.file-max = 2097152
```

Load the new settings:

```bash
sudo sysctl -p
```

Once you save these files, you may need to logout and login again.
