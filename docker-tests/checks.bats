#! /usr/bin/env bats

# Variable SUT_ID should be set outside this script and should contain the ID
# number of the System Under Test.

# Tests
@test 'Replication ok' {
  run bash -c "docker exec -ti ${SUT_ID} redis-cli -h ${SUT_IP} -p 6011 INFO replication"
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ "role:master" ]]
  [[ "${output}" =~ "connected_slaves:2" ]]
}

@test 'Quorum ok' {
  run bash -c "docker exec -ti ${SUT_ID} redis-cli -h ${SUT_IP} -p 6012 SENTINEL ckquorum TRAVIS-master-1"
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ "OK 3 usable Sentinel" ]]
}

@test 'Sentinel voted a new  master' {
  bash -c "docker exec -ti ${SUT_ID} redis-cli -h ${SUT_IP} -p 6011 DEBUG sleep 30"
  run bash -c "docker exec -ti ${SUT_ID} redis-cli -h ${SUT_IP} -p 6012 SENTINEL get-master-addr-by-name TRAVIS-master-1 |sed -e '1q;d'|cut -d' ' -f2"
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ "172.17.0.3" ]] || [[ "${output}" =~ "172.17.0.4" ]]
}
#redis-cli -h 172.17.0.2 -p 6011 DEBUG sleep 30
#redis-cli -h 172.17.0.2 -p 6012 SENTINEL get-master-addr-by-name TRAVIS-master-1  
#redis-cli -h 172.17.0.2 -p 6012 SENTINEL master TRAVIS-master-1
#redis-cli -h 172.17.0.2 -p 6012 SENTINEL slaves TRAVIS-master-1
#redis-cli -h 172.17.0.2 -p 6012 SENTINEL sentinels TRAVIS-master-1
