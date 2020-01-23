---
title: Understanding Dynamic Global Properties
position: 1
description: Maintains global state information
exclude: true
layout: full
---

### Intro

Dynamic Global Properties represents a set of values that are calculated during normal chain operations and reflect the current values of global blockchain properties.

[The API](#example-method-call) returns an object containing information that changes every block interval such as the head block number, the total vesting fund, etc.
    
### Sections

<ul>
<li>Fields</li>
<ul>
{% for sections in site.data.objects.dgpo %}
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

{% for sections in site.data.objects.dgpo %}
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
<hr />
{% endif %}
{% endfor %}
{% endfor %}

### `Not Covered`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Fields not covered in this recipe are:

<ul>
{% for sections in site.data.objects.dgpo %}
{% assign sorted_fields = sections.fields | sort: 'name' %}
{% for field in sorted_fields %}
{% unless field.purpose %}
<li><code>{{field.name}}</code></li>
{% endunless %}
{% endfor %}
{% endfor %}
</ul>

### Example Method Call<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

To retrieve the current results for [`condenser_api.get_dynamic_global_properties`](https://developers.steem.io/apidefinitions/#condenser_api.get_dynamic_global_properties), we can retrieve the current state information using `curl`:

```bash
curl -s --data '{"jsonrpc":"2.0", "method":"condenser_api.get_dynamic_global_properties", "params":[], "id":1}' https://api.steemit.com
```

### Example Output<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

```json
{
   "id":1,
   "jsonrpc":"2.0",
   "result":{
      "head_block_number":24238248,
      "head_block_id":"0171d8a833dc369abd034b0c67d8725f96df9e5b",
      "time":"2018-07-16T22:41:24",
      "current_witness":"xeldal",
      "total_pow":514415,
      "num_pow_witnesses":172,
      "virtual_supply":"283434761.199 STEEM",
      "current_supply":"271729171.190 STEEM",
      "confidential_supply":"0.000 STEEM",
      "current_sbd_supply":"15498201.173 SBD",
      "confidential_sbd_supply":"0.000 SBD",
      "total_vesting_fund_steem":"192913644.627 STEEM",
      "total_vesting_shares":"391296886352.617261 VESTS",
      "total_reward_fund_steem":"0.000 STEEM",
      "init_sbd_supply":"7000000.000 TBD",
      "total_reward_shares2":"0",
      "pending_rewarded_vesting_shares":"379159224.860656 VESTS",
      "pending_rewarded_vesting_steem":"185294.019 STEEM",
      "sbd_interest_rate":0,
      "sbd_print_rate":2933,
      "maximum_block_size":65536,
      "current_aslot":24315228,
      "recent_slots_filled":"340282366920938463463374607431768211400",
      "participation_count":128,
      "last_irreversible_block_num":24238230,
      "vote_power_reserve_rate":10
      "required_actions_partition_percent":2500,
      "target_votes_per_period":50,
      "vote_power_reserve_rate":50,
      "delegation_return_period":432000,
      "reverse_auction_seconds":300,
      "available_account_subsidies":137414104,
      "sbd_stop_percent":1000,
      "sbd_start_percent":900,
      "next_maintenance_time":"2019-11-15T01:44:39",
      "last_budget_time":"2019-11-15T00:44:39",
      "content_reward_percent":6500,
      "vesting_reward_percent":1500,
      "sps_fund_percent":1000,
      "sps_interval_ledger":"15.162 TBD",
      "downvote_pool_percent":2500
   }
}
```
