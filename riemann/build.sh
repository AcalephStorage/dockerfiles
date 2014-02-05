#!/bin/sh

docker build -t acaleph/riemann .
cat <<EOF

NOTE:
-----
    Before running ./run.sh, copy "etc/riemann/riemann.config"
    to "/etc/riemann/riemann.config" on the Docker host
    and modify accordingly.

EOF
