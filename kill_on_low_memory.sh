#!/bin/bash
MEMORY_THRESHOLD=300

function stop(){
  kill -9 $pid
}

function monitor(){
  while :
  do
    memleft=$(free -m | awk 'NR==2 {print $7}')

    if [ $memleft -lt $MEMORY_THRESHOLD ]
    then
      echo "Memory threshold reached: $MEMORY_THRESHOLD"
      stop
      break
    fi

  	sleep 1
  done
}

trap stop EXIT

bash $@ &
pid=$!
monitor
