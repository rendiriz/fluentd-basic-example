#!/bin/sh
while true
do
	echo "Sending logs to Fluentd"
  curl -X POST -d '{"foo":"bar"}' -H 'Content-Type: application/json' http://localhost:9880/web.log
	sleep 10
done