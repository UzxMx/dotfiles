#!/usr/bin/env bash
#
# Install fd (https://github.com/sharkdp/fd)

. $(dirname "$0")/utils.sh

if is_mac; then
  brew_install fd
else
  version=7.4.0
  if has_dpkg; then
    download_and_install_debian_package "https://github.com/sharkdp/fd/releases/download/v${version}/fd_i${version}_amd64.deb"
  else
    basename="fd-v${version}-x86_64-unknown-linux-musl"
    cd /tmp && wget "https://github.com/sharkdp/fd/releases/download/v${version}/${basename}.tar.gz" -O "${basename}.tar.gz"
    tar zxf "$basename.tar.gz"
    cd "$basename" && sudo cp fd /usr/local/bin/ && sudo cp fd.1 /usr/local/share/man/man1/ && sudo mandb
    cd /tmp && rm -rf "$basename" "$basename.tar.gz"
  fi
fi
