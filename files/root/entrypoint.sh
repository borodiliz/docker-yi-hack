#!/bin/bash

set -x
mkdir -p /root/.ssh/


if [[ ! -z $ON_ENTRY_SCRIPT ]] && [[ -f $ON_ENTRY_SCRIPT ]]
then
    $ON_ENTRY_SCRIPT
fi

exec /usr/bin/supervisord --nodaemon -c /etc/supervisor/supervisord.conf
