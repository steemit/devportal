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


## Docker
To run a containerized version of Jekyll for development, a Docker Compose configuration file is already set, defining a `site` container for working with Jekyll:

~~~bash
docker-compose run --rm site bundle install
docker-compose up -d site
~~~

The site will then be accessible via port 4000 on your Docker host (either `localhost` or the IP of your VM if using `boot2docker`).

You can rebuild the site while it's running by calling:

~~~bash
docker-compose run --rm site jekyll build
~~~
