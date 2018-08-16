#!/bin/bash

export KRB5_CONFIG
export KRB5_KTNAME

exec /usr/sbin/remctld -F -f ${REMCTLD_CONFIG} -S -s ${SERVICE_PRINCIPAL} -d
