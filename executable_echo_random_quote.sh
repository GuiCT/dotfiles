#!/bin/bash
LINES=$(wc -l ./quotes | awk '{print $1}')
PRINTED=$(shuf -i 1-$LINES -n 1)
QUOTE=$(sed -n "${PRINTED}p" ./quotes)
echo -e "\033[91m$QUOTE\033[0m"
