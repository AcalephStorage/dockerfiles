#!/bin/sh

docker run -d -v /etc/riemann:/etc/riemann -p 5555:5555 -p 5556:5556 acaleph/riemann
