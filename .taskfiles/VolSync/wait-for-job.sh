#!/usr/bin/env bash

JOB_NAME=$1
NAMESPACE="${2:-default}"

[[ -z "${JOB_NAME}" ]] && echo "No Job" && exit 1

while true; do
    STATUS="$(kubectl -n "${NAMESPACE}" get pod -l job-name="${JOB_NAME}" -o json | jq -rc '.items | .[].status.phase')"
    if [ "${STATUS}" == "Pending" ]; then
        break
    fi
    sleep 1
done
