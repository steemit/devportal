---
position: 9
exclude: true
---

<dl class="dl-horizontal apidefinitions">
	{% for sections in site.data.apidefinitions.witness_api %}
                        {{section.description}}
		{% for method in sections.methods %}
			<section id="{{method.api_method}}">
				<H3>{{method.api_method}}</H3>
				{{method.purpose}}
                                <BR>
                                <B>Query Parameters JSON:</B>
                                <BR>
                                {{method.parameter_json | jsonify}}
                                <BR>
                                <B>Expected Response JSON:</B>
                                <BR>
                                {{method.expected_response_json | jsonify}}
			</section>
                <hr/>
	    {% endfor %}
	{% endfor %}
</dl>

