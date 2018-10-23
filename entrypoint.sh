#!/bin/sh

PYPI_ROOT="${PYPI_ROOT:-/srv/pypi}"
PYPI_PORT=${PYPI_PORT:-80}
PYPI_PASSWD_FILE="${PYPI_PASSWD_FILE:-${PYPI_ROOT}/.htpasswd}"
PYPI_AUTHENTICATE="${PYPI_AUTHENTICATE:-update}"

# make sure the passwd file exists
touch "${PYPI_PASSWD_FILE}"

_overwrite=0

# allow existing packages to be overwritten
if [[ "${PYPI_OVERWRITE}" != "" ]]; then
    _overwrite=1
fi

exec gunicorn -w4 -b ":${PYPI_PORT}" \
"\
pypiserver:app(\
root=\"${PYPI_ROOT}\",\
port=${PYPI_PORT},\
password_file=\"${PYPI_PASSWD_FILE}\",\
authenticated=\"${PYPI_AUTHENTICATE}\",\
overwrite=${_overwrite},\
${PYPI_EXTRA}\
)\
"
