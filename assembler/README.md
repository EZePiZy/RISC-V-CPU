# Assembler files

- Makefile remaings unchanged compared to the one provided
- `format_hex.sh` was modified to create 4 byte (32 bit) words, as exepcted by the `ROM` components
- `assemble.sh` was created to accept the name of a `.s` file from the `programs/` folder as a parameter, assemble it and store the resulting `.mem` file in the programs folder 

### Use in conjunction with `exe.sh` in RTL folder

- If the `exe.sh` file is run with a parameter it will look for the corresponding `.s` file in the programs folder 
- Once found it will assemble the file using `assemble.sh` 
- Finally the resulting `.mem` is copied into CPU as `instruction.mem` in order to be executed