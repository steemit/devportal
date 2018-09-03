
**When setting up the config file it has to be noted that by default, `steemd` runs the `chain`, `p2p`, and `webserver` plugins regardless of any other dependencies**

# API's with their respective plugin dependencies

account_by_key_API :
    <steem/plugins/account_by_key/account_by_key_plugin.hpp>
    <steem/plugins/json_rpc/json_rpc_plugin.hpp>
    https://github.com/steemit/steem/blob/master/libraries/plugins/apis/account_by_key_api/include/steem/plugins/account_by_key_api

account_history_API :
    <steem/plugins/account_history/account_history_plugin.hpp>
    <steem/plugins/json_rpc/json_rpc_plugin.hpp>
    https://github.com/steemit/steem/blob/master/libraries/plugins/apis/account_history_api/include/steem/plugins/account_history_api

block_api:
    <steem/plugins/chain/chain_plugin.hpp>
    <steem/plugins/json_rpc/json_rpc_plugin.hpp> https://github.com/steemit/steem/blob/master/libraries/plugins/apis/block_api/include/steem/plugins/block_api

chain_api :
    <steem/plugins/chain/chain_plugin.hpp>
    <steem/plugins/json_rpc/json_rpc_plugin.hpp>
    https://github.com/steemit/steem/tree/master/libraries/plugins/apis/chain_api/include/steem/plugins/chain_api

condenser_api:
    <steem/plugins/json_rpc/json_rpc_plugin.hpp>
    <steem/plugins/database_api/database_api_plugin.hpp>
    <steem/plugins/block_api/block_api_plugin.hpp>
    https://github.com/steemit/steem/tree/master/libraries/plugins/apis/condenser_api/include/steem/plugins/condenser_api

database_api:
    <steem/plugins/chain/chain_plugin.hpp>
    <steem/plugins/json_rpc/json_rpc_plugin.hpp>
    https://github.com/steemit/steem/tree/master/libraries/plugins/apis/database_api/include/steem/plugins/database_api

debug_node_api:
    <steem/plugins/debug_node/debug_node_plugin.hpp>
    <steem/plugins/database_api/database_api_objects.hpp>
    <steem/plugins/json_rpc/json_rpc_plugin.hpp>
    https://github.com/steemit/steem/tree/master/libraries/plugins/apis/debug_node_api/include/steem/plugins/debug_node_api

follow_api:
    <steem/plugins/follow/follow_plugin.hpp>
    <steem/plugins/json_rpc/json_rpc_plugin.hpp>
    <steem/plugins/json_rpc/utility.hpp>
    <steem/plugins/database_api/database_api_objects.hpp>
    <steem/plugins/reputation_api/reputation_api.hpp>
    https://github.com/steemit/steem/tree/master/libraries/plugins/apis/follow_api/include/steem/plugins/follow_api

market_history_api:
    <steem/plugins/market_history/market_history_plugin.hpp>
    <steem/plugins/json_rpc/json_rpc_plugin.hpp>
    https://github.com/steemit/steem/tree/master/libraries/plugins/apis/market_history_api/include/steem/plugins/market_history_api

network_broadcast_api:
    <steem/plugins/json_rpc/json_rpc_plugin.hpp>
    <steem/plugins/chain/chain_plugin.hpp>
    <steem/plugins/p2p/p2p_plugin.hpp>
    https://github.com/steemit/steem/tree/master/libraries/plugins/apis/network_broadcast_api/include/steem/plugins/network_broadcast_api

rc_api:
    <steem/plugins/rc/rc_plugin.hpp>
    <steem/plugins/json_rpc/json_rpc_plugin.hpp>
    https://github.com/steemit/steem/tree/master/libraries/plugins/apis/rc_api/include/steem/plugins/rc_api

reputation_api:
    <steem/plugins/reputation/reputation_plugin.hpp>
    <steem/plugins/json_rpc/json_rpc_plugin.hpp>
    <steem/plugins/database_api/database_api_objects.hpp>
    https://github.com/steemit/steem/tree/master/libraries/plugins/apis/reputation_api/include/steem/plugins/reputation_api

tags_api:
    <steem/plugins/tags/tags_plugin.hpp>
    <steem/plugins/json_rpc/json_rpc_plugin.hpp>
    <steem/plugins/database_api/database_api_objects.hpp>
    https://github.com/steemit/steem/tree/master/libraries/plugins/apis/tags_api/include/steem/plugins/tags_api

test_api:
    <steem/plugins/json_rpc/json_rpc_plugin.hpp>
    <steem/plugins/json_rpc/utility.hpp>
    https://github.com/steemit/steem/tree/master/libraries/plugins/apis/test_api/include/steem/plugins/test_api

witness_api:
    <steem/plugins/witness/witness_plugin.hpp>
    <steem/plugins/json_rpc/json_rpc_plugin.hpp>
    https://github.com/steemit/steem/tree/master/libraries/plugins/apis/witness_api/include/steem/plugins/witness_api

# Available plugins with any other plugin dependencies listed

## account_by_key_plugin
*dependency plugins*
    <steem/plugins/chain/chain_plugin.hpp>
*definition*
    Used to lookup account information based on a key
*additional account_by_key plugin:*
    account_by_key_objects

## account_history_plugin
*dependency plugins*
    <steem/plugins/chain/chain_plugin.hpp>
*definition*
    Used to lookup account history information

## account_history_rocksdb_plugin
*dependency plugins*
    <steem/plugins/account_history_rocksdb/account_history_rocksdb_objects.hpp>
    <steem/plugins/chain/chain_plugin.hpp>
*definition*
    More efficient way of storing and reading information from the database
*additional account_history_rocksdb plugin:*
    account_history_rocksdb_objects

## block_data_export_plugin
*dependency plugins*
    <steem/plugins/chain/chain_plugin.hpp>
*definition*
    create export file containing block data
*additional block_data_export plugin:*
    exportable_block_data

## block_log_info_plugin
*dependency plugins*
    <steem/plugins/chain/chain_plugin.hpp>
*definition*
    create a block log file with block number, size and hash
*additional block_log_info plugin:*
    block_log_info_objects

## chain_plugin
*dependency plugins*
    none
*definition*
    Connection to the blockchain

## debug_node_plugin
*dependency plugins*
    <steem/plugins/chain/chain_plugin.hpp>
*definition*
    The goal of the debug_node plugin is to start with the live chain, then easily simulate future hypothetical actions. The plugin simulates changes to chain state. For example, you can edit an account's balances and signing keys to enable performing (simulated) actions with that account.
    This plugin allows all sorts of creative "what-if" experiments with the chain.
    https://github.com/steemit/steem/blob/master/doc/debug_node_plugin.md

## follow_plugin
*dependency plugins*
    <steem/plugins/follow/follow_operations.hpp>
    <steem/plugins/chain/chain_plugin.hpp>
*definition*
    Used to lookup information related to reputation and account follow operations
*additional follow plugins:*
    follow_objects
    follow_operations
    inc_performance

## json_rpc_plugin
*dependency plugins*
    none
*definition*
    This plugin holds bindings for all APIs and their methods and can dispatch JSONRPC requests to the appropriate API.
    For a plugin to use the API Register, it needs to specify the register as a dependency.
    Then, during initializtion, register itself using add_api.
*additional json_rpc plugin:*
    utility

## market_history_plugin
*dependency plugins*
    <steem/plugins/chain/chain_plugin.hpp>
*definition*
    Used to lookup market history information. Can return the market and trade history of the internal STEEM:SBD market. The order book, recent trades and the market volume is made available through this plugin.

## p2p_plugin
*dependency plugins*
    <steem/plugins/chain/chain_plugin.hpp>
*definition*
    allowes peer-to-peer communication
*additional p2p plugin:*
    p2p_default_seeds

## rc_plugin
*dependency plugins*
    <steem/plugins/chain/chain_plugin.hpp>
*definition*
    Managing of resources - curation rewards, vesting shares, etc.
*additional rc plugins:*
    rc_curve
        <steem/plugins/rc/rc_utility.hpp>
    rc_export_object
        <steem/plugins/block_data_export/exportable_block_data.hpp>
        <steem/plugins/rc/resource_count.hpp>
    rc_objects
        <steem/plugins/rc/rc_utility.hpp>
        <steem/plugins/rc/resource_count.hpp>
    rc_utility

## reputation_plugin
*dependency plugins*
    <steem/plugins/chain/chain_plugin.hpp>
*definition*
    manage user steemit user reputation (relevant to voting on content)
*additional reputation plugin:*
    reputation_objects

## smt_test_plugin
*dependency plugins*
    <steem/plugins/chain/chain_plugin.hpp>
*definition*

*additional smt_test plugin:*
    smt_test_objects

## stats_export_plugin
*dependency plugins*
    <steem/plugins/chain/chain_plugin.hpp>
    <steem/plugins/block_data_export/block_data_export_plugin.hpp>
*definition*


## statsd_plugin
*dependency plugins*
    none
*definition*
    statistical information logging
*additional statsd plugin:*
    utility
        <steem/plugins/statsd/statsd_plugin.hpp>

## tags_plugin
*dependency plugins*
    <steem/plugins/chain/chain_plugin.hpp>
*definition*
    Used to lookup information about tags, posts, and discussions as well as votes.

## webserver_plugin
*dependency plugins*
    <steem/plugins/json_rpc/json_rpc_plugin.hpp>
*definition*
    webserver user interface

## witness_plugin
*dependency plugins*
    <steem/plugins/chain/chain_plugin.hpp>
    <steem/plugins/p2p/p2p_plugin.hpp>
    <steem/plugins/rc/rc_plugin.hpp>
*definition*
    The witness plugin contains all of the bandwidth logic. Can access the available bandwidth of an account and current reserve ratio.
*additional witness plugins:*
    witness_objects
    witness_export_objects
        <steem/plugins/block_data_export/exportable_block_data.hpp>
        <steem/plugins/witness/witness_objects.hpp