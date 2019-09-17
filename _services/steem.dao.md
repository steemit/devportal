---
title: Steem.DAO
position: 5
---

#### Intro

Steem.DAO is an account on the Steem blockchain ([@steem.dao](https://steemd.com/@steem.dao)) that receives 10% of the [annual new supply]({{ '/tutorials-recipes/understanding-configuration-values#steem_inflation_narrowing_period' | relative_url }}).  These funds are dedicated to the Steem Proposal System (SPS) for platform improvements.

Every day a portion of the SBD fund managed by the Steem.DAO is distributed to various proposals, depending on **a)** how much the proposal is asking for and **b)** how much approval the proposal has.

> The Steem.DAO was a concept proposed by [@blocktrades](https://steemd.com/@blocktrades) to allow Steem users to publicly propose work they are willing to do in exchange for pay. Steem users can then vote on these proposals in almost the same way they vote for witnesses.  It uses stake-weighted votes, but voters can vote for as many proposals as they want.

<sup>See original announcement: [https://steemit.com/steem/@steemitblog/hf21-sps-and-eip-explained](https://steemit.com/steem/@steemitblog/hf21-sps-and-eip-explained)</sup>

#### Tools

* [https://steemproposals.com](https://steemproposals.com) - Steem Proposals UI by [@dmitrydao](https://steemit.com/@dmitrydao)
* [https://steempeak.com/proposals](https://steempeak.com/proposals) - Steem Proposals UI by [@steempeak](https://steemit.com/@steempeak)
* [https://steemitwallet.com/proposals](https://steemitwallet.com/proposals) - Vote for your favorite Steem proposals without leaving the safety of steemitwallet.com.
* [https://joticajulian.github.io/steemexplorer/#/proposals](https://joticajulian.github.io/steemexplorer/#/proposals) - Check who voted what.
* [https://steemit.com/@proposalalert](https://steemit.com/@proposalalert) - Follow this account to be notified of new proposals.

#### API

To access the proposal system by JSON-RPC request, see: [`database_api.list_proposals`]({{ '/apidefinitions/#database_api.list_proposals' | relative_url }}).  Proposal creation by broadcast operation, see: [`create_proposal`]({{ '/apidefinitions/#broadcast_ops_create_proposal' | relative_url }}).
