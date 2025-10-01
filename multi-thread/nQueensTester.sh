#!/bin/bash

if [ -z "$1" ]; then
    echo -e "\nUsage: bash $0 <queens>"
    exit 1
fi

queens=$1
timestamp=$(date +"%Y%m%dT%H%M%S")
log_dir="output/$timestamp"
mkdir -p "$log_dir"
log_file="$log_dir/execution-logs.txt"

log() {
    echo -e "$1" | tee -a "$log_file"
}

log "--- Starting test ---"
log "- Execution with $queens, $(($queens+2)) and $(($queens+4)) queens"$'\n'

for i in 0 2 4; do
    current=$((queens + i))
    log "---------------------"
    log "- Execution with $current queens:"

    result_file="$log_dir/result-$current-queens.txt"

    { time ./executable "$current" > "$result_file"; } 2>>"$log_file"

    exec_output=$(tail -n 3 "$log_file")
    log "$exec_output"

    log "- NQueens script output in file: $result_file"$'\n'
done


log "--- Test finished ---" log "Execution logs saved in: $log_file"