---
position: 6
exclude: true
---

<dl class="dl-horizontal apidefinitions">
	{% for sections in site.data.apidefinitions.market_history_api %}
                        {{sections.description}}
		{% for method in sections.methods %}
			<section id="{{method.api_method}}">
				<H3>{{method.api_method}}</H3>
				{{method.purpose}}
                                <BR>
                                <B>Query Parameters JSON:</B>
                                <BR>
                                <div class="language-json highlighter-rouge">
                                <pre class="language-json highlighter-rouge">
                                <code class="language-json highlighter-rouge">
                                {{method.parameter_json | jsonify}}
                                </code>
                                </pre>
                                </div>                                
                                <BR>
                                <B>Expected Response JSON:</B>
                                <BR>
                                <div class="language-json highlighter-rouge">
                                <pre class="language-json highlighter-rouge">
                                <code class="language-json highlighter-rouge">
                                {{method.expected_response_json | jsonify}}
                                </code>
                                </pre>
                                </div>                                
			</section>
                <hr/>
	    {% endfor %}
	{% endfor %}
</dl>

