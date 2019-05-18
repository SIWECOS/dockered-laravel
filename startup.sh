#!/usr/bin/env bash

if [ "$ARTISAN_GENERATE_KEY" = true ]; then
    php artisan key:generate --force
fi

if [ "$ARTISAN_CACHE" = true ]; then
    php artisan config:cache
    php artisan route:cache
    php artisan event:cache
fi

if [ "$ARTISAN_MIGRATE" = true ]; then
    php artisan migrate --force
fi

if [ "$USE_SCHEDULER" = true ]; then
    cp /supervisord-with-scheduler.conf /etc/supervisor/supervisord.conf
fi

supervisord --nodaemon --configuration /etc/supervisor/supervisord.conf
