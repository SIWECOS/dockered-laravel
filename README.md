# dockered-laravel
This is an optimized docker base image for all the Laravel related SIWECOS projects.

It provides the following features out of the box:

- PHP and Apache Webserver
- Laravel Queue-Worker
- Laravel Scheduler
- MySQL Support
- Internal redis
- Supervisor

## Naming Scheme
Based on the offical php base image, the numbered tags are even with the base image's php version.

## ENV Options
The following options can be set via the project's `Dockerfile`:

| `ENV` Parameter        | Default value | Description                                            |
| ---------------------- | ------------- | ------------------------------------------------------ |
| `ARTISAN_GENERATE_KEY` | `true`        | Generate a fresh laravel key on container startup      |
| `ARTISAN_CACHE`        | `true`        | Cache laravel config and routes for better performance |
| `ARTISAN_MIGRATE`      | `false`       | Run database migrations on container startup           |
| `USE_SCHEDULER`        | `false`       | Use the laravel scheduler                              |

For further details have a look at the `startup.sh` script.
