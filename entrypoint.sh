#!/bin/sh

PYPI_ROOT="${PYPI_ROOT:-/srv/pypi}"
PYPI_PORT=${PYPI_PORT:-80}
PASSWD_FILE="${PASSWD_FILE:-${PYPI_ROOT}/.htpasswd}"

# make sure the passwd file exists
touch "${PASSWD_FILE}"

/usr/bin/pypi-server --port ${PYPI_PORT} --passwords "${PASSWD_FILE}" "${PYPI_ROOT}"
