#!/bin/sh

PYPI_ROOT="${PYPI_ROOT:-/srv/pypi}"
PYPI_PORT=${PYPI_PORT:-80}
PASSWD_FILE="${PASSWD_FILE:-${PYPI_ROOT}/.htpasswd}"
OVERWRITE=${OVERWRITE:-false}

# make sure the passwd file exists
touch "${PASSWD_FILE}"

_extra=""

# allow existing packages to be overwritten
if ${OVERWRITE}; then
    _extra="${_extra} --overwrite"
fi

/usr/bin/pypi-server --port ${PYPI_PORT} --passwords "${PASSWD_FILE}" ${_extra} "${PYPI_ROOT}"
