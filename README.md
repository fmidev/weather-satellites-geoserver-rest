# Container recipe for Geoserver REST

This recipe is automatically built on new version tags, and the image
is available from
https://quay.io/repository/fmi/weather-satellites-geoserver-rest

The container can be used for two separate tasks:

* Add new images to WMS layers based in incoming Posttroll messages
* Delete old images from WMS layers

## Configuration

The configuration files should be mounted to `/config/` directory.

Even if no environment variables are set, a file
`/config/env-variables` file should be present.

### Adding images to WMS layers

The configuration should be placed in
`/config/geoserver_posttroll_update.yaml`. For actual configuration,
see https://github.com/fmidev/geoserver-rest/

### Cleaning images from WMS layers

The cleaning is run when the container is started, and approximately
every 6 hours after that. This will later be made configurable.

The configuration should be placed in
`/config/geoserver_delete_old_granules.yaml` file. For actual
configuration, see https://github.com/fmidev/geoserver-rest/
