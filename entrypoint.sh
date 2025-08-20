#!/usr/bin/bash

_term() {
  echo "Entrypoint caught SIGTERM signal"
  kill -TERM "$child" 2>/dev/null
  echo "Waiting for child process to exit"
  wait "$child"
}

trap _term SIGTERM

source /opt/conda/.bashrc
source /config/env-variables

micromamba activate

# If cleaning cycle has not been defined in /config/env-variables,
# use the default cycle of 15 minutes (900 seconds)
if [ "$CLEANING_CYCLE" == "" ]; then
    CLEANING_CYCLE=900
fi

if [ -e /config/geoserver_posttroll_update.yaml ]; then
    /opt/conda/bin/posttroll_adder.py /config/geoserver_posttroll_update.yaml &
    child=$!
    wait "$child"
elif [ -e /config/geoserver_add_granule.yaml ]; then
    /opt/conda/bin/add_granule.py /config/geoserver_add_granule.yaml
elif [ -e /config/geoserver_delete_old_granules.yaml ]; then
    while `true`; do
	/opt/conda/bin/delete_old_granules_and_files.py /config/geoserver_delete_old_granules.yaml
	sleep $CLEANING_CYCLE
    done
fi
