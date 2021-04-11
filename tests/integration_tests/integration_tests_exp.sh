timeout 10s ./integration_tests_processA.sh &

timeout 10s ./integration_tests_processB.sh &

wait 

./integration_tests_processC.sh




