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

    output_and_time=$( { time ./executable "$current"; } 2>&1 )

    time_output=$(echo "$output_and_time" | grep -E "^(real|user|sys)")
    program_output=$(echo "$output_and_time" | grep -vE "^(real|user|sys)")

    echo "$time_output" | tee -a "$log_file"

    if [[ -n "$program_output" ]]; then
        echo "$program_output" | tee -a "$log_file"
        echo "$program_output" > "$result_file"
        log "- NQueens script output in file: $result_file"$'\n'
    else
        log "- NQueens script output: (no output generated)"$'\n'
    fi
done

log "--- Test finished ---"
log "Execution logs saved in: $log_file"