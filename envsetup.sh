ipfs() {
  echo "running ipfs with args: $*"
  ./go-ipfs/cmd/ipfs/ipfs "$@"
}

ipfs_build_run() {
  cd go-ipfs && make build && cd .. || return
  ipfs "$@"
}
