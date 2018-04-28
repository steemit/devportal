---
position: 99
exclude: true
---

{% for sections in site.data.apidefinitions.broadcast_ops %}
{{sections.description | markdownify}}
{% for op in sections.ops %}
<div style="float: right;">
{% if op.since %}
<span class="info"><strong><small>Since: {{op.since}}</small></strong></span>
{% endif %}
{% if op.virtual %}
<span class="info"><strong><small>Virtual Operation</small></strong></span>
{% endif %}
</div>
<h4 id="broadcast_ops_{{ op.name | slug }}">
<code>{{op.name}}</code>
<a href="#broadcast_ops_{{ op.name | slug}}">
<i class="fas fa-link fa-xs"></i></a>
</h4>
{{op.purpose}}
<h5 id="{{ op.name | slug }}-roles">Roles: <code>{{op.roles}}</code></h5>
<h5 id="{{ op.name | slug }}-parameter">Parameters: <code>{{op.params}}</code></h5>
{% if op.json_examples %}
<h5 id="{{ op.name | slug }}-json-examples">Example Op:</h5>
{% for json_example in op.json_examples %}
```json
{{json_example | neat_json}}
```
{% endfor %}
{% endif %}
<hr />
{% endfor %}
{% endfor %}
