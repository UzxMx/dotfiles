usage_cert() {
  cat <<-EOF
Usage: openssl cert <host | path-to-a-cert-pem> [-t]

Get server certificate for a host, or when a certificate pem file is specified,
show its content.

Options:
  -t show certificate content

Example:
  $> openssl cert example.com
  $> openssl cert cert.pem
EOF
  exit 1
}

cmd_cert() {
  if [ -n "$1" -a -f "$1" ]; then
    cat "$1" | openssl x509 -text -noout
    exit
  else
    check_host "$@"
  fi

  local host
  local options=()
  while [ "$#" -gt 0 ]; do
    case "$1" in
      -t)
        options+=(-text -noout)
        ;;
      -*)
        usage_cert
        ;;
      *)
        host="$1"
        ;;
    esac
    shift
  done
  (openssl s_client -connect "$host:443" -servername "$host" 2>/dev/null < /dev/null || true) | openssl x509 "${options[@]}"
}
