#!/bin/bash
#check if docker it's OK

ARG1=$(docker ps -a | grep Up | wc -l)

if [[ ${ARG1} -eq 13 ]]; then
exit 0

elif [[ ${ARG1} -eq 12 ]]; then
exit 1

else
exit 2
fi
