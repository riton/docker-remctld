#!/bin/bash

export KRB5_CONFIG
export KRB5_KTNAME

exec /usr/sbin/remctld -m -F -f ${REMCTLD_CONFIG} -S -s ${SERVICE_PRINCIPAL} -d
