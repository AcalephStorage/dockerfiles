#!/bin/sh

# The following assume we're running on a(n Ubuntu) host with /etc/riemann
docker run -d -v /etc/riemann:/etc/riemann -p 5555:5555 -p 5556:5556 acaleph/riemann
