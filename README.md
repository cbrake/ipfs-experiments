# IPFS experiments

This repo is a simple wrapper repo used for my experiemnts with IPFS.

## Reference

- https://talk.fission.codes/t/redirects-manifests-and-content-type-for-ipfs-gateway/2297
- https://github.com/ipfs/specs/issues/257
- https://github.com/ipfs/go-ipfs/issues/7392

## Set up IPFS directory to test 404 handling

- `. envsetup.sh`
- `ipfs_build_and_run daemon`
- open http://localhost:5001/webui in browser
- create a new folder named `test`
- upload ipfs-404.html to that folder
- upload another real file to test -- say `print.pdf`
- navigate up and click share link for `test` folder, you'll get something like:
  https://ipfs.io/ipfs/QmYLBSwfVipdfZampxUfoDnMbEbiX9aVejHk3EBcBhJ4BQ
- now you can browser local http gateway:
  http://localhost:8080/ipfs/QmYLBSwfVipdfZampxUfoDnMbEbiX9aVejHk3EBcBhJ4BQ
  - this will provide a directory list of the files
- you can get a file from the directory by doing fetching:
  https://ipfs.io/ipfs/QmYLBSwfVipdfZampxUfoDnMbEbiX9aVejHk3EBcBhJ4BQ/print.pdf
- getting a non-existant file should give you the contents of ipfs-404.html

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
