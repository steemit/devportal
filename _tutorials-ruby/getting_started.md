---
title: 'RB: Getting Started'
position: 0
description: To access the Steem blockchain using Ruby install the Radiator gem httpsgithubcominertia186radiatorhttpsgithubcominertia186radiator  Full documentation on Radiator api methods are hosted on rubydocinfohttpwwwrubydocinfogemsradiator
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Getting Started](https://github.com/steemit/devportal-tutorials-rb/tree/master/tutorials/00_getting_started) can be downloaded as part of the [RB tutorials repository](https://github.com/steemit/devportal-tutorials-rb).</span>
<br>



### Setup

The following is a minimal `Gemfile` for running `.rb` files in these examples.

Add `gem 'radiator'` to your `Gemfile`.  Then install the gem:

```bash
bundle install
```

It is also possible to install `radiator` directly with `gem`:

```bash
gem install radiator
```

Then, to execute a script without a `Gemfile`, add to the top of your `.rb` files:

```ruby
require 'radiator'
```

Then, use the `ruby` command with `radiator` specified:

```bash
ruby -r radiator myscript.rb
```

### Examples

The tutorials on this site are available within this site's repository.  To get a copy, clone this repository, change directory to `devportal/_includes/tutorials-ruby` and do a `bundle install` to install the required local gems.

From there, you can see all of the `.rb` files referenced on this site.

```bash
git clone https://github.com/steemit/devportal.git
cd devportal/_includes/tutorials-ruby/
bundle install
```

### Typical-Usage

Most methods can be accessed by creating an instance of `Radiator::Api`.  It is also possible to specify a different node by passing a `url` option.

Radiator also internally supports failover by specifying the `failover_urls` option.

To use the defaults:

```ruby
api = Radiator::Api.new
```

To override the `url` option:

```ruby
api = Radiator::Api.new(url: 'https://rpc.steemliberator.com')
```

To override both `url` and `failover_urls` options:

```ruby
options = {
  url: 'https://rpc.steemliberator.com',
  failover_urls: [
    'https://gtg.steem.house:8090',
    'https://steemd.minnowsupportproject.org',
    'https://steemd.privex.io',
  ]
}
api = Radiator::Api.new(options)
```

### Next Step

If you'd like to dive right into the first tutorial, have a look at: [Blog Feed](https://github.com/steemit/devportal-tutorials-rb/tree/master/tutorials/01_blog_feed)

---
