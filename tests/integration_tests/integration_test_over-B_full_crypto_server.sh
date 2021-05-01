#!/bin/bash
NGTCP2_FOLDER="/root/evaluation/unencrypted_stack/ngtcp2"

taskset -c 0 ip netns exec mr_server ${NGTCP2_FOLDER}/examples/server -q --htdocs ${NGTCP2_FOLDER}/examples/servers_folder/  --max-dyn-length 4g  10.2.2.101 7777  ${NGTCP2_FOLDER}/examples/server.key ${NGTCP2_FOLDER}/examples/server.cert
