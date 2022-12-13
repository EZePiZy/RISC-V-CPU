#!/bin/bash

# Assemble a given program by putting into myprog,
# Using makefile to assmeble it
# then move and rename hex to CPU directory where it is executed

echo "[AS] assembling $1.s"

# cleanup
rm -rf myprog
mkdir myprog

cp ../programs/$1.s myprog/$1.s

echo >> myprog/$1.s # add extra line break at the end

make hexfile

# assuming no errors occur

# rm ../CPU/instruction.mem

# cp myprog/$1.s.hex ../CPU/instruction.mem
cp myprog/$1.s.hex ../programs/$1.mem

rm -rf myprog