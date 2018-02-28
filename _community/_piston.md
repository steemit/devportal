---
title: PistonCLI
position: 4
---

Piston is a command line tool to interact with the STEEM network.  Piston is
written in Python and highly customizable for building steem tools and performing
wallet operations.

**Piston** - [https://github.com/xeroc/python-steem](https://github.com/xeroc/python-steem)

Install with pip3:
<br/>
~~~
sudo apt-get install libffi-dev libssl-dev python-dev python3-pip
pip3 install steem
~~~

Manual installation:

~~~
git clone https://github.com/xeroc/python-steem/
cd python-steem
python3 setup.py install --user
~~~

Upgrade

~~~
pip3 install steem --user --upgrade
~~~

Additional dependencies

steemapi.steemasyncclient:

- asyncio==3.4.3
- pyyaml==3.11
- Documentation

Thanks to readthedocs.io, the documentation can be viewed on pysteem.com

Documentation is written with the help of sphinx and can be compile to html with:

~~~
cd docs
make html
~~~
