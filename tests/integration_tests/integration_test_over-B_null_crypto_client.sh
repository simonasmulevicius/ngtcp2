#!/bin/bash
NGTCP2_FOLDER="/root/evaluation/unencrypted_stack/ngtcp2"

taskset -c 1 ip netns exec mr_client ${NGTCP2_FOLDER}/examples/client -q --download ${NGTCP2_FOLDER}/examples/clients_folder -P  10.2.2.101 7777  https://10.2.2.101/index_10.0MB.html

