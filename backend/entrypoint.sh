#!/bin/bash

# wait for postgres
function postgres_ready() {
python << END
import sys
import psycopg2

try:
    conn = psycopg2.connect(dbname='proddb', user='admin', password='adminpass', host='postgresdb')
except psycopg2.OperationalError:
    sys.exit(-1)
sys.exit(0)
END
}

until postgres_ready; do
    >&2 echo "Postgres is unavailable - sleeping"
    sleep 1
done

python manage.py makemigrations --no-input
python manage.py migrate --no-input
python manage.py loaddata superuser_fixture.json

python manage.py collectstatic --no-input

exec gunicorn backend.wsgi:application -b 0.0.0.0:8000 --reload
