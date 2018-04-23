---
position: 10
exclude: true
---

{% for sections in site.data.apidefinitions.block_api %}
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
{% if method.curl_examples %}
**Example `curl`:**
{% for curl in method.curl_examples %}
```bash
curl -s --data '{{curl}}' https://api.steemit.com
```
{% endfor %}
{% endif %}
---
{% endfor %}
{% endfor %}
