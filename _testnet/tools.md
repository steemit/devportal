---
title: Tools
position: 1
description: Directory of third-party testnet tools
---

Testnet ID | Tool | Purpose
-----------|------|--------
{%
  for tool in site.data.testnet.tools
  %}{{
    tool.testnet_id
  }} | [{{tool.name}}]({{tool.url}}) | {{
    tool.purpose
  }}
{% endfor %}
