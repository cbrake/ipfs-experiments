ipfs() {
  echo "running ipfs with args: $*"
  ./go-ipfs/cmd/ipfs/ipfs "$@"
}

ipfs_build_run() {
  if ! (cd go-ipfs && make build); then
    echo "Error building go-ipfs"
    return
  fi
  ipfs "$@"
}
