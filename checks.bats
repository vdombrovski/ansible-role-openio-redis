#! /usr/bin/env bats

# Variable SUT_ID should be set outside this script and should contain the ID
# number of the System Under Test.

# Tests
#@test 'Conscience up' {
#  run bash -c "docker exec -ti ${SUT_ID} gridinit_cmd status TRAVIS-conscience-0"
#  echo "output: "$output
#  echo "status: "$status
#  [[ "${status}" -eq "0" ]]
#  [[ "${output}" =~ " UP " ]]
#}

#redis-cli -h 172.17.0.2 -p 6011 INFO replication
#redis-cli -h 172.17.0.2 -p 6011 DEBUG sleep 30
#redis-cli -h 172.17.0.2 -p 6012 SENTINEL get-master-addr-by-name TRAVIS-master-1  
#redis-cli -h 172.17.0.2 -p 6012 SENTINEL ckquorum TRAVIS-master-1  
#redis-cli -h 172.17.0.2 -p 6012 SENTINEL master TRAVIS-master-1
#redis-cli -h 172.17.0.2 -p 6012 SENTINEL slaves TRAVIS-master-1
#redis-cli -h 172.17.0.2 -p 6012 SENTINEL sentinels TRAVIS-master-1
