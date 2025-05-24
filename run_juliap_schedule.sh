#!/bin/bash

# Settings
OUTPUT_FILE="juliap_schedule_results.csv"
N=1150
P=16
SCHEDULES=("static" "static,1" "dynamic,5" "guided,10")
REPEAT=3
BINARY="./bin/juliap_runner"

# Header
echo "schedule,run,seconds" > "$OUTPUT_FILE"

for sched in "${SCHEDULES[@]}"; do
  export OMP_SCHEDULE="$sched"
  echo "Testing schedule: $sched"
  for ((r=1; r<=REPEAT; r++)); do
    result=$($BINARY -n $N -p $P | tail -n 1)
    time=$(echo "$result" | cut -d',' -f3)
    echo "$sched,$r,$time" >> "$OUTPUT_FILE"
  done
done

echo "Done. Results saved to $OUTPUT_FILE"

