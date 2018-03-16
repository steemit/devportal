---
title: Tutorials
exclude: true
---
{% assign nav = site.data.nav.toc | where: "collection", "tutorials" | first %}
<section id="{{ doc.id | slugify }}" class="doc-content {{ doc.id | slugify }}">
	By following these tutorials you will master developing applications on top of **Steem**.
	<section class="left-docs">
		<ul>
			{% if nav.docs %}
				{% assign sorted_docs = nav.docs | sort: "position" %}
				{% for doc in sorted_docs %}
					{% assign col = site.collections | where: "id", doc.collection | first %}
					{% if doc %}
						<li>
							{{ doc.id }} <a href="{{ doc.id }}">{{ doc.title }}</a>
						</li>
					{% endif %}
				{% endfor %}
			{% endif %}
		</ul>
	</section>
</section>
