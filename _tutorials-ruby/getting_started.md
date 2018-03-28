---
title: Getting Started
position: 1
exclude: true
layout: main-script
description: Common tasks for getting ruby apps to access the blockchain
main_script: tutorials-ruby/Gemfile
main_type: ruby
main_script_anchor: Setup
right_code: |
    <p class="right-section-title">Typical-Usage</p>
    
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
---

To access the Steem blockchain using Ruby, install the Radiator gem: [https://github.com/inertia186/radiator](https://github.com/inertia186/radiator).  Full documentation on Radiator api methods are hosted on [rubydoc.info](http://www.rubydoc.info/gems/radiator).

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

### Typical-Usage

Most methods can be accessed by creating an instance of `Radiator::Api`.  It is also possible to specify a different node by passing a `url` option.

Radiator also internally supports failover by specifying the `failover_urls` option.
