#!/bin/sh

/bic/bin/ltapi &

# wait for api started
while ! nc -z localhost 4000 < /dev/null > /dev/null 2>&1; do
  echo "waiting for ltapi!!!"
  sleep 1
done

/bic/bin/ltcoordinator &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?