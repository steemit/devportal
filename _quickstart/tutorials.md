---
title: Tutorials
position: 3
right_code: |
    ~~~ python
    from steem import Steem
    import os
    import json
    steem = Steem(wif="<posting-key-for-default-author>")
    for c in steem.stream_comments():
    if "anything you want" in c["body"]:
    ~~~
    {: title="Auto Reply Bot"} 
---

#### Auto Reply Bot

The most easy auto-reply bot can be coded with just a few lines of code. 

Install steem-py:
~~~ bash
$ sudo apt-get install libffi-dev libssl-dev python-dev python3-pip
$ pip3 install steem
~~~

Write your first bot in Python(seen on right-side code example)

