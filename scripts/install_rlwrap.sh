#!/usr/bin/env bash
#
# Install rlwrap

. $(dirname "$0")/utils.sh

if is_mac; then
  brew_install rlwrap
elif has_yum; then
  sudo yum install -y rlwrap
else
  abort "Unsupported system"
fi