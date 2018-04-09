<p align="center">
  <img src="https://raw.githubusercontent.com/steemit/devportal/master/images/steemdev.png" alt="Steemit API Portal" width="226">
  <br>
  <br>
  
</p>

# Steemit API Portal

Steemit is the social media platform where everyone gets paid for creating and curating content.

The following API documents provide details on how to interact with the Steem blockchain database API which can get information on accounts, content, blocks and much more!

The developer portal will also serve as a toolbox for steem clients, libraries, and language wrappers.

## Develop

Steemit Portal was built with [Jekyll](http://jekyllrb.com/) version 3.1.6, but should support newer versions as well.

Install the dependencies with [Bundler](http://bundler.io/):

~~~bash
$ bundle install
~~~

Run `jekyll` commands through Bundler to ensure you're using the right versions:

~~~bash
$ bundle exec jekyll serve
~~~

You can now test locally at
~~~bash
http://localhost:4000
~~~

Optionally, when running `jekyll` commands through Bundler, append `--host x.x.x.x` with the external IP address of the server to be able to connect remotely:
~~~bash
$ bundle exec jekyll serve --host x.x.x.x
~~~
~~~bash
http://x.x.x.x:4000
~~~

### Managing API Definitions

This project maintains a copy of API Definitions in `_data/apidefinitions` in YAML format.  The purpose of these `.yml` files is to reflect details of each method.

In order to accurately synchronize the `.yml` files, we've added a `rake` task to evaluate the current state of the actual API, as reflected by the `jsonrpc` methods.

This command will check the current state of the API Definitions, report any differences, and write a new `.yml` file if these differences exist:

```bash
$ bundle exec rake scrape:api_defs
```

Typical output:

```
Definitions for: account_by_key_api, methods: 1
Definitions for: account_history_api, methods: 3
Definitions for: condenser_api, methods: 85
Definitions for: database_api, methods: 46
Definitions for: follow_api, methods: 10
Definitions for: jsonrpc, methods: 2
Definitions for: market_history_api, methods: 7
Definitions for: network_broadcast_api, methods: 3
Definitions for: tags_api, methods: 20
Definitions for: witness_api, methods: 2
Methods added or changed: 0
```
