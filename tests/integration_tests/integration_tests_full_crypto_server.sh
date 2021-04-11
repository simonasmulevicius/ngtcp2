NGTCP2_FOLDER="/root/evaluation/unencrypted_stack/ngtcp2"

${NGTCP2_FOLDER}/examples/server -q --htdocs ${NGTCP2_FOLDER}/examples/servers_folder/  --max-dyn-length 1g  127.0.0.1 7777  ${NGTCP2_FOLDER}/examples/server.key ${NGTCP2_FOLDER}/examples/server.cert
