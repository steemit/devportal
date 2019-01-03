default: serve

serve: vendor
	bundle exec jekyll serve --port 8080

vendor:
	bundle install --path vendor/bundle

clean:
	rm -rf _site

distclean: clean
	rm -rf vendor
