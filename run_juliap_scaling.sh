#!/bin/bash

# Settings
OUTPUT_FILE="juliap_scaling_results.csv"
N_VALUES=(85 1150)
P_VALUES=(1 2 4 8 16 24 32)
REPEAT=3
BINARY="./bin/juliap_runner"

# Header
echo "n,p,run,seconds" > "$OUTPUT_FILE"

for n in "${N_VALUES[@]}"; do
  for p in "${P_VALUES[@]}"; do
    for ((r=1; r<=REPEAT; r++)); do
      echo "Running: n=$n, p=$p, run $r..."
      result=$($BINARY -n $n -p $p | tail -n 1)
      # Expected output format: n,p,time
      time=$(echo "$result" | cut -d',' -f3)
      echo "$n,$p,$r,$time" >> "$OUTPUT_FILE"
    done
  done
done

echo "Done. Results saved to $OUTPUT_FILE"
