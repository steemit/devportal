---
title: Transactions
position: 7
---

#### Manual Constructing and Signing of Transactions
------


This is a low level class. Do not use this class unless you  
know what you are doing!

This class is under development and meant for people that are  
looking into the low level construction and signing of various transactions.

#### Loading Transactions Class
------

We load the class for manual transaction construction via:

``` sourceCode
from steembase import transactions
```

#### Construction
------

Now we can use the predefined transaction formats, e.g. `vote` or `comment` as follows:

1.  define the expiration time
2.  define a JSON object that contains all data for that transaction
3.  load that data into the corresponding **operations** class
4.  collect multiple operations
5.  get some blockchain parameters to prevent replay attack
6.  Construct the actual **transaction** from the list of operations
7.  sign the transaction with the corresponding private key(s)

**Example A: Vote**

``` sourceCode
expiration = transactions.formatTimeFromNow(60)
op = transactions.Vote(
    **{"voter": voter,
       "author": message["author"],
       "permlink": message["permlink"],
       "weight": int(weight)}
)
ops    = [transactions.Operation(op)]
ref_block_num, ref_block_prefix = transactions.getBlockParams(rpc)
tx     = transactions.Signed_Transaction(ref_block_num=ref_block_num,
                                         ref_block_prefix=ref_block_prefix,
                                         expiration=expiration,
                                         operations=ops)
tx = tx.sign([wif])
```

**Example A: Comment**

``` sourceCode
# Expiration time 60 seconds in the future
expiration = transactions.formatTimeFromNow(60)
op = transactions.Comment(
    **{"parent_author": parent_author,
       "parent_permlink": parent_permlink,
       "author": author,
       "permlink": postPermlink,
       "title": postTitle,
       "body": postBody,
       "json_metadata": ""}
)
ops    = [transactions.Operation(op)]
ref_block_num, ref_block_prefix = transactions.getBlockParams(rpc)
tx     = transactions.Signed_Transaction(ref_block_num=ref_block_num,
                                         ref_block_prefix=ref_block_prefix,
                                         expiration=expiration,
                                         operations=ops)
tx = tx.sign([wif])
```

Broadcasting
------------

For broadcasting, we first need to convert the transactions class into a JSON object. After that, we can braodcast this to the network:

``` sourceCode
# Convert python class to JSON
tx = transactions.JsonObj(tx)

# Broadcast JSON to netwo
```
pandoc 1.19.1


