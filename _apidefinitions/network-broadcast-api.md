---
position: 7
exclude: true
---

{% for sections in site.data.apidefinitions.network_broadcast_api %}
{{sections.description | markdownify}}
{% for method in sections.methods %}
#### {{method.api_method}}
{{method.purpose}}
##### Query Parameters JSON:
```json
{{method.parameter_json | jsonify | neat_json}}
```
##### Expected Response JSON:
```json
{{method.expected_response_json | jsonify | neat_json}}
```
---
{% endfor %}
{% endfor %}
