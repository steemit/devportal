---
title: 'PY: Account Reputation'
position: 20
description: "Would you like to know how to interpret account reputation to more human readable format, then this tutorial is for you."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Account Reputation](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/20_account_reputation) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



## Intro

Account reputation is long integer string which requires special function or formula to convert in more human readable format. We will define that function in this tutorial and show how to fetch and interpret reputation.

## Steps

1.  [**App setup**](#app-setup) - Library install and import
1.  [**Account list**](#account-list) - List of predefined accouns to select from
1.  [**Reputation interpret**](#reputation-details) - Reputation converting function
1.  [**Print output**](#print-output) - Print results in output

#### 1. App setup <a name="app-setup"></a>

In this tutorial we will use 4 packages, `pick` - helps us to select filter interactively. `steem` - steem-python library, interaction with Blockchain. `pprint` - print results in better format and `math` to perform some math calculations.

First we import all libraries and initialize Steem class

```python
    import pprint
    import math
    from pick import pick

    # initialize Steem class
    from steem import Steem

    s = Steem()
```

#### 2. Account list <a name="account-list"></a>

Next we will show predefined account list to select and setup `pick` properly.

```python
    title = 'Please choose account: '
    options = ["steemitblog","esteemapp","busy.org","demo"]

    # get index and selected filter name
    option, index = pick(options, title)

    # option is printed as reference
    pprint.pprint("Selected: "+option)
```

This will show us list of accounts to select in terminal/command prompt. And after selection we will fetch account details from Blockchain with `get_accounts` function.

```python
    user = s.get_accounts([option])
```


#### 3. Reputation interpret <a name="reputation-details"></a>

Next we will define reputation interpreter:

```python
def rep_log10(rep):
    """Convert raw steemd rep into a UI-ready value centered at 25."""
    def log10(string):
        leading_digits = int(string[0:4])
        log = math.log10(leading_digits) + 0.00000001
        num = len(string) - 1
        return num + (log - int(log))

    rep = str(rep)
    if rep == "0":
        return 25

    sign = -1 if rep[0] == '-' else 1
    if sign < 0:
        rep = rep[1:]

    out = log10(rep)
    out = max(out - 9, 0) * sign  # @ -9, $1 earned is approx magnitude 1
    out = (out * 9) + 25          # 9 points per magnitude. center at 25
    return round(out, 2)
```

Above function will cover all edge cases, for example, if account is new their reputation is `0` hence, default starting reputation will be `25`. If reputation negative that's also considered.

#### 4. Print output <a name="print-output"></a>

After we have fetched account details from Blockchain, all we have to do is to use defined function above to interpret account's `reputation` field into meaningful number.

```python
    # print specified account's reputation
    pprint.pprint(rep_log10(user[0]['reputation']))
```

That's it. We have successfully interpreted reputation.

### To Run the tutorial

1.  [review dev requirements](getting_started)
1.  clone this repo
1.  `cd tutorials/20_account_reputation`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see output in terminal/command prompt screen.

---
