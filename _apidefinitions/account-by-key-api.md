---
position: 1
exclude: true
---

{% for sections in site.data.apidefinitions.account_by_key_api %}
{{sections.description | markdownify}}
{% for method in sections.methods %}
#### {{method.api_method}}
{{method.purpose}}
##### Query Parameters JSON:
```json
{{method.parameter_json | neat_json}}
```
##### Expected Response JSON:
```json
{{method.expected_response_json | neat_json}}
```
---
{% endfor %}
{% endfor %}
