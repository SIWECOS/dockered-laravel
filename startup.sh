#!/usr/bin/env bash

if [ "$ARTISAN_GENERATE_KEY" = true ]; then
    php artisan key:generate --force
fi

if [ "$ARTISAN_CACHE" = true ]; then
    php artisan config:cache
    php artisan route:cache
fi

if [ "$ARTISAN_MIGRATE" = true ]; then
    php artisan migrate --force
fi

supervisord --nodaemon --configuration /etc/supervisor/supervisord.conf
