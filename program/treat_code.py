#!/usr/bin/python3

import sys

if len(sys.argv) < 3:
    print("Usage: {} <Bin code File> <Memory file>".format(sys.argv[0]))
    exit(1)

BIN_CODE = sys.argv[1]
MEM_FILE = sys.argv[2]

file_in_obj  = open(BIN_CODE, "r")
file_out_memfile = open(MEM_FILE, "w+")

file_out_memfile.writelines('@0000' + '\n')

# address jump for the boot code(Boot From RAM 0x0000)
for i in range(0,32):
    file_out_memfile.writelines('31000000' + '\n')

file_in_content = file_in_obj.readlines()

def objdump_line_to_hex(line):
    # Only select lines with instructions
    if line.isspace():
        return None
    if not(line.startswith(' ')):
        return None

    # Shape:
    # <WS> <OFFSET>: <WS> <HEX DATA> <WS> <ASM INSTRUCTION>

    colon_index = line.index(':')
    line = line[colon_index + 1:]
    line = line.strip()
    hex = line[:8]

    return hex

for line in file_in_content:
    hex = objdump_line_to_hex(line)

    if hex == None:
        continue

    reversed_hex = hex[::-1]
    file_out_memfile.writelines(reversed_hex + '\n')
