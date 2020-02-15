#!/usr/bin/env bash
#
# Install rg (https://github.com/BurntSushi/ripgrep)

. $(dirname "$0")/utils.sh

if is_mac; then
  brew_install ripgrep
elif has_yum; then
  sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
  sudo yum install -y ripgrep
else
  abort "Unsupported system"
fi
