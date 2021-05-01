#!/bin/bash
NGTCP2_FOLDER="/root/evaluation/unencrypted_stack/ngtcp2"
CLIENT_FILE=${NGTCP2_FOLDER}/examples/clients_folder/index_10.0MB.html
SERVER_FILE=${NGTCP2_FOLDER}/examples/servers_folder/index_10.0MB.html
TIMEOUT=60

## PREREQUISITES:
# ${NGTCP2_FOLDER}/examples/server.key 
# ${NGTCP2_FOLDER}/examples/server.cert


# Taken from: https://stackoverflow.com/questions/9713104/loop-over-tuples-in-bash
# for i in "null_encryption_via_A ./integration_tests_null_crypto_server.sh       ./integration_tests_null_crypto_client.sh" #"full_encryption_via_B ./integration_test_over-B_null_crypto_server.sh ./integration_test_over-B_null_crypto_client.sh"
for i in "full_encryption_via_A ./integration_tests_full_crypto_server.sh       ./integration_tests_full_crypto_client.sh"  "null_encryption_via_A ./integration_tests_null_crypto_server.sh       ./integration_tests_null_crypto_client.sh"  "full_encryption_via_B ./integration_test_over-B_full_crypto_server.sh ./integration_test_over-B_full_crypto_client.sh" "full_encryption_via_B ./integration_test_over-B_null_crypto_server.sh ./integration_test_over-B_null_crypto_client.sh"
# for i in  "full_encryption_via_B ./integration_test_over-B_full_crypto_server.sh ./integration_test_over-B_full_crypto_client.sh" 
#           "null_encryption_via_B ./integration_test_over-B_null_crypto_server.sh ./integration_test_over-B_null_crypto_client.sh"
do
  set -- $i

  echo "-----------------------"
  echo "Test:   ${1}"
  echo "  Server:   ${2}"
  echo "  Client:   ${3}"
  echo "-----------------------"

  # ARRANGE: 
  #   PRECONDITION: Clean existing client's file if it exists
  #   Adopted from: https://linuxize.com/post/bash-check-if-file-exists/
  if [ -f "$CLIENT_FILE" ]; then
    rm "$CLIENT_FILE"
  fi

  # ACT:
  echo " > running server..."
  timeout "${TIMEOUT}s" ${2} &

  echo " > running client..."
  # 1. Run client in parallel
  timeout "${TIMEOUT}s" ${3} &
  wait



  # ASSERT:
  if [ -f "$CLIENT_FILE" ]; then
      echo "$CLIENT_FILE exists."
      # Check that server's and client's sample files are identical
      #   Adopted from: https://stackoverflow.com/questions/12900538/fastest-way-to-tell-if-two-files-have-the-same-contents-in-unix-linux
      if cmp --silent -- "$CLIENT_FILE" "$SERVER_FILE"; then
        echo "INFO: Sent and received files are identical."

        printf '%s\n' "[Test full crypto: PASSED]" >&1

        # Clean sample file
        rm "$CLIENT_FILE"
      else
        # Throw an error that test has failed       
        echo "INFO: $CLIENT_FILE is different from $SERVER_FILE."
        printf '%s\n' "[Test full crypto: FAILED]" >&2

        echo "INFO: NOT deleting CLIENT_FILE file"
        exit 1
      fi

  else
      # Throw an error that test has failed 	
      echo "INFO: $CLIENT_FILE does not exist."
      printf '%s\n' "[Test full crypto: FAILED]" >&2 
      exit 1 
  fi
done