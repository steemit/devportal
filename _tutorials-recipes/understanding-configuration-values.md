---
title: Understanding Configuration Values
position: 1
description: Low level blockchain constants
exclude: true
layout: full
---

### Intro

These values underpin the behavior of the entire blockchain.  In a sense, each witness votes for these configuration values every time they sign a block.  Unlike many of the [Dynamic Global Properties]({{ '/tutorials-recipes/understanding-dynamic-global-properties' | relative_url }}), these values never change at runtime (e.g., as a witness, in order to change them, you typically must shut down your node, make the change, recompile, and run).

See: [config.hpp](https://github.com/steemit/steem/blob/master/libraries/protocol/include/steem/protocol/config.hpp)

Usually, these configuration values are universally adhered to, but there are situations where these values can and should be altered, like in the case of deploying a new blockchain (typically a testnet).  Some of the values that do not affect consensus, like [`STEEM_SOFT_MAX_COMMENT_DEPTH`](#STEEM_SOFT_MAX_COMMENT_DEPTH), are allowed to change to some extent.

### Sections

<ul>
<li>Fields</li>
<ul>
{% for sections in site.data.objects.config %}
{% assign sorted_fields = sections.fields | sort: 'name' %}
{% for field in sorted_fields %}
{% if field.purpose %}
{% unless field.removed %}
<li><a href="#{{ field.name | slug}}"><code>{{field.name}}</code></a></li>
{% endunless %}
{% endif %}
{% endfor %}
{% for field in sorted_fields %}
{% if field.purpose %}
{% if field.removed %}
<li><del><a href="#{{ field.name | slug}}"><code>{{field.name}}</code></a></del></li>
{% endif %}
{% endif %}
{% endfor %}
{% endfor %}
</ul>
<li><a href="#not-covered">Not Covered</a></li>
<li><a href="#example-method-call">Example Method Call</a></li>
<li><a href="#example-output">Example Output</a></li>
</ul>

{% for sections in site.data.objects.config %}
{% assign sorted_fields = sections.fields | sort: 'name' %}
{% for field in sorted_fields %}
{% if field.purpose %}
<h3 id="{{field.name | slug}}">
<code>{{field.name}}</code>
<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm"></i></a>
</h3>
<ul style="float: right; list-style: none;">
{% if field.deprecated %}
<li class="warning"><strong><small>Deprecated</small></strong></li>
{% elsif field.removed %}
<li class="danger"><strong><small>Removed</small></strong></li>
{% endif %}
{% if field.since %}
<li class="success"><strong><small>Since: {{field.since}}</small></strong></li>
{% endif %}
{% assign keywords = field.name | keywordify | escape %}
{% assign search_url = '/search/?q=' | append: keywords | split: '_' | join: ' ' %}
<li class="info"><strong><small><a href="{{ search_url | relative_url }}">Related <i class="fas fa-search fa-xs"></i></a></small></strong></li>
</ul>
{{ field.purpose | liquify | markdownify }}
{% if field.examples.size > 0 %}
<ul>
<li>Examples:
<ul>
{% for example in field.examples %}
<li>{{example | liquify | markdownify }}</li>
{% endfor %}
</ul>
</li>
</ul>
{% endif %}
{% if field.links.size > 0 %}
{% assign links = field.links | join: ', ' | liquify %}
See: {{ links }}
{% endif %}
<br />
<br />
<hr />
{% endif %}
{% endfor %}
{% endfor %}

### `Not Covered`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Fields not covered in this recipe are:

<ul>
{% for sections in site.data.objects.config %}
{% assign sorted_fields = sections.fields | sort: 'name' %}
{% for field in sorted_fields %}
{% unless field.purpose %}
<li><code>{{field.name}}</code></li>
{% endunless %}
{% endfor %}
{% endfor %}
</ul>

### Example Method Call<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

```bash
curl -s --data '{"jsonrpc":"2.0", "method":"condenser_api.get_config", "params":[], "id":1}' https://api.steemit.com
```

### Example Output<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

```json
{
   "jsonrpc":"2.0",
   "result":{
      "IS_TEST_NET":true,
      "TESTNET_BLOCK_LIMIT":3000000,
      "SMT_MAX_VOTABLE_ASSETS":2,
      "SMT_VESTING_WITHDRAW_INTERVAL_SECONDS":604800,
      "SMT_UPVOTE_LOCKOUT":43200,
      "SMT_EMISSION_MIN_INTERVAL_SECONDS":21600,
      "SMT_EMIT_INDEFINITELY":4294967295,
      "SMT_MAX_NOMINAL_VOTES_PER_DAY":1000,
      "SMT_MAX_VOTES_PER_REGENERATION":7000,
      "SMT_DEFAULT_VOTES_PER_REGEN_PERIOD":50,
      "SMT_DEFAULT_PERCENT_CURATION_REWARDS":2500,
      "SMT_INITIAL_VESTING_PER_UNIT":1000000,
      "SMT_BALLAST_SUPPLY_PERCENT":10,
      "SBD_SYMBOL":{"nai":"@@000000013", "precision":3},
      "STEEM_INITIAL_VOTE_POWER_RATE":40,
      "STEEM_REDUCED_VOTE_POWER_RATE":10,
      "STEEM_100_PERCENT":10000,
      "STEEM_1_PERCENT":100,
      "STEEM_ACCOUNT_RECOVERY_REQUEST_EXPIRATION_PERIOD":12000000,
      "STEEM_ACTIVE_CHALLENGE_COOLDOWN":"86400000000",
      "STEEM_ACTIVE_CHALLENGE_FEE":{"amount":"2000", "precision":3, "nai":"@@000000021"},
      "STEEM_ADDRESS_PREFIX":"TST",
      "STEEM_APR_PERCENT_MULTIPLY_PER_BLOCK":"102035135585887",
      "STEEM_APR_PERCENT_MULTIPLY_PER_HOUR":"119577151364285",
      "STEEM_APR_PERCENT_MULTIPLY_PER_ROUND":"133921203762304",
      "STEEM_APR_PERCENT_SHIFT_PER_BLOCK":87,
      "STEEM_APR_PERCENT_SHIFT_PER_HOUR":77,
      "STEEM_APR_PERCENT_SHIFT_PER_ROUND":83,
      "STEEM_BANDWIDTH_AVERAGE_WINDOW_SECONDS":604800,
      "STEEM_BANDWIDTH_PRECISION":1000000,
      "STEEM_BENEFICIARY_LIMIT":128,
      "STEEM_BLOCKCHAIN_PRECISION":1000,
      "STEEM_BLOCKCHAIN_PRECISION_DIGITS":3,
      "STEEM_BLOCKCHAIN_HARDFORK_VERSION":"0.23.0",
      "STEEM_BLOCKCHAIN_VERSION":"0.23.0",
      "STEEM_BLOCK_INTERVAL":3,
      "STEEM_BLOCKS_PER_DAY":28800,
      "STEEM_BLOCKS_PER_HOUR":1200,
      "STEEM_BLOCKS_PER_YEAR":10512000,
      "STEEM_CASHOUT_WINDOW_SECONDS":3600,
      "STEEM_CASHOUT_WINDOW_SECONDS_PRE_HF12":3600,
      "STEEM_CASHOUT_WINDOW_SECONDS_PRE_HF17":3600,
      "STEEM_CHAIN_ID":"18dcf0a285365fc58b71f18b3d3fec954aa0c141c44e4e5cb4cf777b9eab274e",
      "STEEM_COMMENT_REWARD_FUND_NAME":"comment",
      "STEEM_COMMENT_TITLE_LIMIT":256,
      "STEEM_CONTENT_APR_PERCENT":3875,
      "STEEM_CONTENT_CONSTANT_HF0":"2000000000000",
      "STEEM_CONTENT_CONSTANT_HF21":"2000000000000",
      "STEEM_CONTENT_REWARD_PERCENT_HF16":7500,
      "STEEM_CONTENT_REWARD_PERCENT_HF21":6500,
      "STEEM_CONVERSION_DELAY":"302400000000",
      "STEEM_CONVERSION_DELAY_PRE_HF_16":"604800000000",
      "STEEM_CREATE_ACCOUNT_DELEGATION_RATIO":5,
      "STEEM_CREATE_ACCOUNT_DELEGATION_TIME":"2592000000000",
      "STEEM_CREATE_ACCOUNT_WITH_STEEM_MODIFIER":30,
      "STEEM_CURATE_APR_PERCENT":3875,
      "STEEM_CUSTOM_OP_DATA_MAX_LENGTH":8192,
      "STEEM_CUSTOM_OP_ID_MAX_LENGTH":32,
      "STEEM_DEFAULT_SBD_INTEREST_RATE":1000,
      "STEEM_DOWNVOTE_POOL_PERCENT_HF21":2500,
      "STEEM_EQUIHASH_K":6,
      "STEEM_EQUIHASH_N":140,
      "STEEM_FEED_HISTORY_WINDOW":84,
      "STEEM_FEED_HISTORY_WINDOW_PRE_HF_16":168,
      "STEEM_FEED_INTERVAL_BLOCKS":1200,
      "STEEM_GENESIS_TIME":"2016-01-01T00:00:00",
      "STEEM_HARDFORK_REQUIRED_WITNESSES":17,
      "STEEM_HF21_CONVERGENT_LINEAR_RECENT_CLAIMS":"503600561838938636",
      "STEEM_INFLATION_NARROWING_PERIOD":250000,
      "STEEM_INFLATION_RATE_START_PERCENT":978,
      "STEEM_INFLATION_RATE_STOP_PERCENT":95,
      "STEEM_INIT_MINER_NAME":"initminer",
      "STEEM_INIT_PUBLIC_KEY_STR":"TST6LLegbAgLAy28EHrffBVuANFWcFgmqRMW13wBmTExqFE9SCkg4",
      "STEEM_INIT_SUPPLY":"250000000000",
      "STEEM_SBD_INIT_SUPPLY":"7000000000",
      "STEEM_INIT_TIME":"1970-01-01T00:00:00",
      "STEEM_IRREVERSIBLE_THRESHOLD":7500,
      "STEEM_LIQUIDITY_APR_PERCENT":750,
      "STEEM_LIQUIDITY_REWARD_BLOCKS":1200,
      "STEEM_LIQUIDITY_REWARD_PERIOD_SEC":3600,
      "STEEM_LIQUIDITY_TIMEOUT_SEC":"604800000000",
      "STEEM_MAX_ACCOUNT_CREATION_FEE":1000000000,
      "STEEM_MAX_ACCOUNT_NAME_LENGTH":16,
      "STEEM_MAX_ACCOUNT_WITNESS_VOTES":30,
      "STEEM_MAX_ASSET_WHITELIST_AUTHORITIES":10,
      "STEEM_MAX_AUTHORITY_MEMBERSHIP":40,
      "STEEM_MAX_BLOCK_SIZE":393216000,
      "STEEM_SOFT_MAX_BLOCK_SIZE":2097152,
      "STEEM_MAX_CASHOUT_WINDOW_SECONDS":86400,
      "STEEM_MAX_COMMENT_DEPTH":65535,
      "STEEM_MAX_COMMENT_DEPTH_PRE_HF17":6,
      "STEEM_MAX_FEED_AGE_SECONDS":604800,
      "STEEM_MAX_INSTANCE_ID":"281474976710655",
      "STEEM_MAX_MEMO_SIZE":2048,
      "STEEM_MAX_WITNESSES":21,
      "STEEM_MAX_MINER_WITNESSES_HF0":1,
      "STEEM_MAX_MINER_WITNESSES_HF17":0,
      "STEEM_MAX_PERMLINK_LENGTH":256,
      "STEEM_MAX_PROXY_RECURSION_DEPTH":4,
      "STEEM_MAX_RATION_DECAY_RATE":1000000,
      "STEEM_MAX_RESERVE_RATIO":20000,
      "STEEM_MAX_RUNNER_WITNESSES_HF0":1,
      "STEEM_MAX_RUNNER_WITNESSES_HF17":1,
      "STEEM_MAX_SATOSHIS":"4611686018427387903",
      "STEEM_MAX_SHARE_SUPPLY":"1000000000000000",
      "STEEM_MAX_SIG_CHECK_DEPTH":2,
      "STEEM_MAX_SIG_CHECK_ACCOUNTS":125,
      "STEEM_MAX_TIME_UNTIL_EXPIRATION":3600,
      "STEEM_MAX_TRANSACTION_SIZE":65536,
      "STEEM_MAX_UNDO_HISTORY":10000,
      "STEEM_MAX_URL_LENGTH":127,
      "STEEM_MAX_VOTE_CHANGES":5,
      "STEEM_MAX_VOTED_WITNESSES_HF0":19,
      "STEEM_MAX_VOTED_WITNESSES_HF17":20,
      "STEEM_MAX_WITHDRAW_ROUTES":10,
      "STEEM_MAX_WITNESS_URL_LENGTH":2048,
      "STEEM_MIN_ACCOUNT_CREATION_FEE":0,
      "STEEM_MIN_ACCOUNT_NAME_LENGTH":3,
      "STEEM_MIN_BLOCK_SIZE_LIMIT":65536,
      "STEEM_MIN_BLOCK_SIZE":115,
      "STEEM_MIN_CONTENT_REWARD":{"amount":"1000", "precision":3, "nai":"@@000000021"},
      "STEEM_MIN_CURATE_REWARD":{"amount":"1000", "precision":3, "nai":"@@000000021"},
      "STEEM_MIN_PERMLINK_LENGTH":0,
      "STEEM_MIN_REPLY_INTERVAL":20000000,
      "STEEM_MIN_REPLY_INTERVAL_HF20":3000000,
      "STEEM_MIN_ROOT_COMMENT_INTERVAL":300000000,
      "STEEM_MIN_COMMENT_EDIT_INTERVAL":3000000,
      "STEEM_MIN_VOTE_INTERVAL_SEC":3,
      "STEEM_MINER_ACCOUNT":"miners",
      "STEEM_MINER_PAY_PERCENT":100,
      "STEEM_MIN_FEEDS":7,
      "STEEM_MINING_REWARD":{"amount":"1000", "precision":3, "nai":"@@000000021"},
      "STEEM_MINING_TIME":"2016-01-01T00:00:00",
      "STEEM_MIN_LIQUIDITY_REWARD":{"amount":"1200000", "precision":3, "nai":"@@000000021"},
      "STEEM_MIN_LIQUIDITY_REWARD_PERIOD_SEC":60000000,
      "STEEM_MIN_PAYOUT_SBD":{"amount":"20", "precision":3, "nai":"@@000000013"},
      "STEEM_MIN_POW_REWARD":{"amount":"1000", "precision":3, "nai":"@@000000021"},
      "STEEM_MIN_PRODUCER_REWARD":{"amount":"1000", "precision":3, "nai":"@@000000021"},
      "STEEM_MIN_TRANSACTION_EXPIRATION_LIMIT":15,
      "STEEM_MIN_TRANSACTION_SIZE_LIMIT":1024,
      "STEEM_MIN_UNDO_HISTORY":10,
      "STEEM_NULL_ACCOUNT":"null",
      "STEEM_NUM_INIT_MINERS":1,
      "STEEM_OWNER_AUTH_HISTORY_TRACKING_START_BLOCK_NUM":1,
      "STEEM_OWNER_AUTH_RECOVERY_PERIOD":60000000,
      "STEEM_OWNER_CHALLENGE_COOLDOWN":"86400000000",
      "STEEM_OWNER_CHALLENGE_FEE":{"amount":"30000", "precision":3, "nai":"@@000000021"},
      "STEEM_OWNER_UPDATE_LIMIT":0,
      "STEEM_POST_AVERAGE_WINDOW":86400,
      "STEEM_POST_REWARD_FUND_NAME":"post",
      "STEEM_POST_WEIGHT_CONSTANT":1600000000,
      "STEEM_POW_APR_PERCENT":750,
      "STEEM_PRODUCER_APR_PERCENT":750,
      "STEEM_PROXY_TO_SELF_ACCOUNT":"",
      "STEEM_SBD_INTEREST_COMPOUND_INTERVAL_SEC":2592000,
      "STEEM_SECONDS_PER_YEAR":31536000,
      "STEEM_PROPOSAL_FUND_PERCENT_HF0":0,
      "STEEM_PROPOSAL_FUND_PERCENT_HF21":1000,
      "STEEM_RECENT_RSHARES_DECAY_TIME_HF19":"1296000000000",
      "STEEM_RECENT_RSHARES_DECAY_TIME_HF17":"2592000000000",
      "STEEM_REVERSE_AUCTION_WINDOW_SECONDS_HF6":1800,
      "STEEM_REVERSE_AUCTION_WINDOW_SECONDS_HF20":900,
      "STEEM_REVERSE_AUCTION_WINDOW_SECONDS_HF21":300,
      "STEEM_ROOT_POST_PARENT":"",
      "STEEM_SAVINGS_WITHDRAW_REQUEST_LIMIT":100,
      "STEEM_SAVINGS_WITHDRAW_TIME":"259200000000",
      "STEEM_SBD_START_PERCENT_HF14":200,
      "STEEM_SBD_START_PERCENT_HF20":900,
      "STEEM_SBD_STOP_PERCENT_HF14":500,
      "STEEM_SBD_STOP_PERCENT_HF20":1000,
      "STEEM_SECOND_CASHOUT_WINDOW":259200,
      "STEEM_SOFT_MAX_COMMENT_DEPTH":255,
      "STEEM_START_MINER_VOTING_BLOCK":864000,
      "STEEM_START_VESTING_BLOCK":201600,
      "STEEM_TEMP_ACCOUNT":"temp",
      "STEEM_UPVOTE_LOCKOUT_HF7":60000000,
      "STEEM_UPVOTE_LOCKOUT_HF17":300000000,
      "STEEM_UPVOTE_LOCKOUT_SECONDS":300,
      "STEEM_VESTING_FUND_PERCENT_HF16":1500,
      "STEEM_VESTING_WITHDRAW_INTERVALS":13,
      "STEEM_VESTING_WITHDRAW_INTERVALS_PRE_HF_16":104,
      "STEEM_VESTING_WITHDRAW_INTERVAL_SECONDS":604800,
      "STEEM_VOTE_DUST_THRESHOLD":50000000,
      "STEEM_VOTING_MANA_REGENERATION_SECONDS":432000,
      "STEEM_SYMBOL":{"nai":"@@000000021", "precision":3},
      "VESTS_SYMBOL":{"nai":"@@000000037", "precision":6},
      "STEEM_VIRTUAL_SCHEDULE_LAP_LENGTH":"18446744073709551615",
      "STEEM_VIRTUAL_SCHEDULE_LAP_LENGTH2":"340282366920938463463374607431768211455",
      "STEEM_VOTES_PER_PERIOD_SMT_HF":50,
      "STEEM_MAX_LIMIT_ORDER_EXPIRATION":2419200,
      "STEEM_DELEGATION_RETURN_PERIOD_HF0":3600,
      "STEEM_DELEGATION_RETURN_PERIOD_HF20":432000,
      "STEEM_RD_MIN_DECAY_BITS":6,
      "STEEM_RD_MAX_DECAY_BITS":32,
      "STEEM_RD_DECAY_DENOM_SHIFT":36,
      "STEEM_RD_MAX_POOL_BITS":64,
      "STEEM_RD_MAX_BUDGET_1":"17179869183",
      "STEEM_RD_MAX_BUDGET_2":268435455,
      "STEEM_RD_MAX_BUDGET_3":2147483647,
      "STEEM_RD_MAX_BUDGET":268435455,
      "STEEM_RD_MIN_DECAY":64,
      "STEEM_RD_MIN_BUDGET":1,
      "STEEM_RD_MAX_DECAY":4294967295,
      "STEEM_ACCOUNT_SUBSIDY_PRECISION":10000,
      "STEEM_WITNESS_SUBSIDY_BUDGET_PERCENT":12500,
      "STEEM_WITNESS_SUBSIDY_DECAY_PERCENT":210000,
      "STEEM_DEFAULT_ACCOUNT_SUBSIDY_DECAY":347321,
      "STEEM_DEFAULT_ACCOUNT_SUBSIDY_BUDGET":797,
      "STEEM_DECAY_BACKSTOP_PERCENT":9000,
      "STEEM_BLOCK_GENERATION_POSTPONED_TX_LIMIT":5,
      "STEEM_PENDING_TRANSACTION_EXECUTION_LIMIT":200000,
      "STEEM_TREASURY_ACCOUNT":"steem.dao",
      "STEEM_TREASURY_FEE":10000,
      "STEEM_PROPOSAL_MAINTENANCE_PERIOD":3600,
      "STEEM_PROPOSAL_MAINTENANCE_CLEANUP":86400,
      "STEEM_PROPOSAL_SUBJECT_MAX_LENGTH":80,
      "STEEM_PROPOSAL_MAX_IDS_NUMBER":5,
      "STEEM_NETWORK_TYPE":"testnet",
      "STEEM_DB_FORMAT_VERSION":"1"
   },
   "id":1
}
```
