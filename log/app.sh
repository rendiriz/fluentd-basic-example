#!/bin/sh
while true
do
	echo "Sending logs to Fluentd"
  curl -X POST -d '{"type":"http"}' -H 'Content-Type: application/json' http://localhost:9880/web.test
	sleep 10
done