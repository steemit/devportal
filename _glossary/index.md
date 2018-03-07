---
position: 1
exclude: true
---

<dl class="dl-horizontal glossary">
	{% for sections in site.data.glossary.index %}
	   	<h3>{{sections.name}}</h3>
	   	{% for entry in sections.items %}
	   		<section id="{{entry.term}}">
			   	<dt>{{entry.term}}</dt>
			    <dd>{{entry.def}}</dd>
		    </section>
	    {% endfor %}
		<hr/>
	{% endfor %}
</dl>

