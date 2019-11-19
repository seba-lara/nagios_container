#!/bin/bash

ARG1=$(ps | grep -w /home/root/services/xbeegateway.sh | wc -l)
ARG2=$(ps | grep -w /home/root/app/xbee-gateway.py | wc -l)

if [[ ${ARG1} -ge 2 ]] && [[ ${ARG2} -ge 2 ]]; then

exit 0
else
echo "Error en la aplicacion"
exit 2
fi
