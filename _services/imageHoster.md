# Definition

Very simply put, imagehoster is a Steem-powered image hosting and proxying service. This service allowes you to upload any image and instead of storing just a link to the image, it stores a copy of the image on the server. This means that the image will not be removed if it is removed from the original upload site, nor when the post is inactive for long periods of time. The image will be available, anytime you need it.
More information on Imagehoster can be found [HERE](https://github.com/steemit/imagehoster/blob/master/README.md)

## The API

Below are examples of how to process images with the API

**1. Upload an image**

`POST /<username>/<signature>`

This returns a JSON object container the URL to the uploaded image, ex:

{
    "url": "https://images.example.com/DQmZi174Xz96UrRVBMNRHb6A2FfU3z1HRPwPPQCgSMgdiUT/test.jpg"
}

For this to go ahead it requires a signature from a Steem account in good standing.

**2. Fetch an uploaded image**

`GET /<image_hash>/[<filename>]`

This downloads a previously uploaded image.

`filename` is optional but can be provided to help users and applications understand the contect type (Content-Type header will still always reflect actual image type)

**3. Proxy and resize an image**

`GET /<width>x<hight>/<image_url>`

This downloads and serves the provided `image_url`. Something to note is that a copy will be taken of the image and will be served on subsequent requests, so even if the upstream is removed or changes, you will still get the original from the proxy endpoint.

`width` and `height` can be set to `0` to preserve the image dimensions, if they are `>0` the image will be aspect resized (down-sample only) to fit inside the rectangle.

**4. Get user avatar image**

`GET /u/<username>/avatar/[<size>]`

This presents the avatar for `username`. If no avatar is set, a default image will be served. This default is set in the service config.

The sizes are:
 * small - 64x64
 * medium - 128x128
 * large - 512x512

The avatars follow the same sizing rules as proxied images, so you not guaranteed to get a square image, just an image fitting inside of the `size` square

## Signing uploads

Uploads also require a signature made by a Steem accounts' posting authority. The account has to also be above a certain (service configurable) reputation threshold.

Creating a signature for `node.js` and with `dsteem`:

```javascript
const dsteem = require('dsteem')
const crypto = require('crypto')
const fs = require('fs')

const [wif, file] = process.argv.slice(2)

if (!wif || !file) {
    process.stderr.write(`Usage: ./sign.js <posting_wif> <file>\n`)
    process.exit(1)
}

const data = fs.readFileSync(file)
const key = dsteem.PrivateKey.fromString(wif)
const imageHash = crypto.createHash('sha256')
    .update('ImageSigningChallenge')
    .update(data)
    .digest()

process.stdout.write(key.sign(imageHash).toString() + '\n')
```

### How to run

This imagehoster demo must be run through linux due to a dependency on the `make` commandline.
You will also require `node.js` and `yarn` to run

* git clone https://github.com/steemit/imagehoster

* Run `make devserver`

This will pull in all dependencies and spin up a hot-reloading development server. From there the HTTP methods can be used to alter the image loaded from the <./test> module.

* Run `make lint` to load the autolinter.
* Run `make test` to run the unit tests for the active functions.

Default configuration variables are in <./config/defailt.toml> and can be overridden by environment variables as definded in <./config/custom-enfironment-variables.toml>

The load order for the config files are: env vars > `config/$NODE_ENV.toml` > `config/default.toml`
