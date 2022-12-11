#!/bin/bash

set -euo pipefail

# changed to x4 to match with the way memory is loaded now
od -v -An -t x4 "$1.bin" | tr -s '\n' | awk '{$1=$1};1' > "$1.hex"