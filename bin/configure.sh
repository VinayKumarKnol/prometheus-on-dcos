#!/bin/sh

# /bin/configure retrieves Mesos' state-summary and outputs the hostname of each agent in Prometheus service discovery format

while [ 1 ]
do
  wget -qO- http://leader.mesos:5050/state-summary \
    | /bin/rq -jJ "at slaves | spread | at hostname | map (ip) => { ip + ':61091' } | collect | map (n)=>{ {'targets':n} } |	 collect" \
    > /tmp/agents.json

  wget -qO- http://leader.mesos:5050/state-summary \
    | /bin/rq -jJ "at slaves | spread | at hostname | map (ip) => { ip + ':9100' } | collect | map (n)=>{ {'targets':n} } | collect" \
    > /tmp/node-expo-agents.json

  sleep 60
done
