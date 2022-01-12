# IPFS experiments

This repo is a simple wrapper repo and set of test files used for my experiemnts
with IPFS.

## Reference

- https://talk.fission.codes/t/redirects-manifests-and-content-type-for-ipfs-gateway/2297
- https://github.com/ipfs/specs/issues/257
- https://github.com/ipfs/go-ipfs/issues/7392

## Current work

https://github.com/fission-suite/go-ipfs/pull/4

## Set up IPFS and test basic redirects

- `. envsetup.sh`
- `git submodule update --init`
- `ipfs_build_and_run daemon`
- open http://localhost:5001/webui in browser
- create a new folder named `test`
- upload the contents of `test-ipfs-files` to your `test` folder in ipfs.
- navigate up and click share link for `test` folder, you'll get something like:
  https://ipfs.io/ipfs/SOMECID
- now you can modify link to browse on local http gateway by replacing
  https://ipfs.io with http://localhost:8080. Ex:
  http://localhost:8080/ipfs/SOMECID
  - this will serve the contents of the `index.html` file you uploaded.
- getting a non-existant file should give you the contents of `ipfs-404.html`
- test [`_redirects`](test-ipfs-files/_redirects)
  - browsing to http://localhost:8080/ipfs/SOMECID/test should redirect you to
    the `/` and serve up the index file.
  - browsing to http://localhost:8080/ipfs/SOMECID/hi should redirect you to
    `hi.html` and serve up the index file.

Note, every time you update or change a file in the test directory, the CID of
the test directory changes!

## Notes on go-ipfs http gateway operation

- if path is directory, and `index.html` exists in that dir, than that file is
  served without a redirect
- if file is not found in directory, then `ipfs-404.html` is served with `404`
  code

## Re-directs

Cloudflare supports a
[`_redirects`](https://developers.cloudflare.com/pages/platform/redirects) file
with format of:

`[source] [destination] [code?]`

Examples:

```
/home301 / 301
/home302 / 302
/querystrings /?query=string 301
/twitch https://twitch.tv
/trailing /trailing/ 301
/notrailing/ /nottrailing 301
/blog/* https://blog.my.domain/:splat
/products/:code/:name /products?code=:code&name=:name
```

go has http.Redirect function.
