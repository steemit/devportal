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


