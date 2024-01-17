#!/usr/bin/bash

source /opt/conda/.bashrc
source /config/env-variables

micromamba activate

# Clean images every 6 hours
CLEANING_CYCLE=21600

if [ -e /config/geoserver_posttroll_update.yaml ]; then
    /opt/conda/bin/posttroll_adder.py /config/geoserver_posttroll_update.yaml
elif [ -e /config/geoserver_add_granule.yaml ]; then
    /opt/conda/bin/add_granule.py /config/geoserver_add_granule.yaml
elif [ -e /config/geoserver_delete_old_granules.yaml ]; then
    while `true`; do
	/opt/conda/bin/delete_old_granules_and_files.py /config/geoserver_delete_old_granules.yaml
	sleep $CLEANING_CYCLE
    done
fi
