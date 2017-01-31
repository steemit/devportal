---
title: Getting Started 
position: 1
---

The Python **STEEM** -library can be used to interface with the STEEM blockchain. It comes with

-   it’s own wallet,
-   a configuration database
-   default settings that enable to get started right away

Installation
------------

Install with `python-steem`:

~~~ bash
$ sudo apt-get install libffi-dev libssl-dev python-dev
$ python-steem3 install steem
~~~

Manual installation:

    $ git clone https://github.com/xeroc/python-steem/
    $ cd python-steem
    $ python3 setup.py install --user

Upgrade
-------

    $ python-steem install --user --upgrade

Additional dependencies
-----------------------

`steemapi.steemasyncclient`:
 * `asyncio==3.4.3`
 * `pyyaml==3.11`

Documentation
-------------

Thanks to readthedocs.io, the documentation can be viewed on
[pysteem.com](http://pysteem.com)

Documentation is written with the help of sphinx and can be compile to
html with:

    cd docs
    make html