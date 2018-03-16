---
title: Tutorials
section: Tutorials
exclude: true
---
{% assign nav = site.data.nav.toc | where: "collection", "tutorials" | first %}
<section id="{{ doc.id | slugify }}" class="doc-content {{ doc.id | slugify }}">
	<section class="left-docs">
		<p>By following these tutorials you will master developing applications on top of **Steem**.</p>
		{% if nav.docs %}
			{% assign sorted_nav_docs = nav.docs | sort: "position" %}
			{% for nav_doc in sorted_nav_docs %}
				{% assign collection = site.collections | where: "id", nav_doc.collection | first %}
				{% if collection %}
					<h3>{{ nav_doc.title }}</h3>
					<ul>
						{% for doc in collection.docs %}
						<li>
							<a href="{{ doc.id }}">{{ doc.title }}</a>
							<p class="overview">{{ doc.description }}</p>
						</li>
						{% endfor %}
					</ul>
				{% endif %}
			{% endfor %}
		{% endif %}
	</section>
</section>
