#!/bin/bash
while true; do
  ./tfs > data/logs/output.log &
  PID=$!
  echo $PID > tfs.pid
  wait $PID
  sleep 5
done