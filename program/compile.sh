#! /bin/bash

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] || [ -z $4 ] ; then
	echo "Usage: $0 <asm/gcc> <Input Code Path> <Input Bitstream> <Output Bitstream> [Output Code Path]"
	exit 1
fi

echo " "

INSTR_MMI="./instr.mmi"
DATA_MMI="./data.mmi"
BIN_CODE_DUMP="./tmp_bincode.dump"
MEM_FILE="./bincode.mem"

PULPINO_ROOT=".."

ARCH="rv32i"
SIZE_OPT_FLAGS="-fdata-sections -ffunction-sections -Wl,--gc-sections"
CFLAGS="-O3 -g -ffreestanding -nostartfiles -nostdlib -nodefaultlibs $SIZE_OPT_FLAGS"
CINCLUDES="-I$PULPINO_ROOT/sw/libs/sys_lib/inc -I$PULPINO_ROOT/sw/libs/string_lib/inc"
CFILES=startup.S ../sw/libs/sys_lib/src/*.c

asm_gcc_choice="$1"
code_path="$2"
in_bitstream_path="$3"
out_bitstream_path="$4"

if [ -z $5 ]; then
	out_code_path="./tmp.o"
else
	out_code_path="$5"
fi

echo "Code: $code_path"
echo "Input Bitstream: $in_bitstream_path"
echo "Output Bitstream: $out_bitstream_path"

echo "Compiling the code $code_path -> $out_code_path..."

if [ "$asm_gcc_choice" = "gcc" ]; then
	echo "Compiling with GCC"

    riscv32-unknown-elf-gcc \
		-march=$ARCH \
        $CFLAGS \
        $CINCLUDES \
        $CFILES "$code_path" \
		-o "$out_code_path" \
		-T Linkerscript.ld
else
	echo "Compiling with Assembler"

    riscv32-unknown-elf-as \
		-march=$ARCH \
		"$code_path" \
		-o "$out_code_path"
fi

if test -f "$out_code_path"; then
	echo "Compile successfully"
else
	echo "Compile error !"
	echo "Please check the syntax"
	exit 2
fi

riscv32-unknown-elf-objdump -d "$out_code_path" > $BIN_CODE_DUMP

echo "Convert the bin code..."

python3 ./treat_code.py "$BIN_CODE_DUMP" "$MEM_FILE"

if [ -z "$MEM_FILE" ]; then
	echo "Failed to convert the bin code (python3)"
	exit 2
fi

echo "Start to update the instruction ram data of bitstream..."


updatemem \
	-force \
	--meminfo "$INSTR_MMI" \
	--data "$MEM_FILE" \
	--bit "$in_bitstream_path" \
	--proc instr_mem \
	--out "$out_bitstream_path"

if [ $? -ne 0 ]; then
	echo "Failed to update instruction memory"
	exit 1
fi

echo " "

echo "-------------------------------------"
echo "Instruction RAM has been updated"
echo "Start to update the Data ram of bitstream..."
echo "-------------------------------------"

updatemem \
	-force \
	--meminfo "$DATA_MMI" \
	--data "$MEM_FILE" \
	--bit "$out_bitstream_path" \
	--proc data_mem \
	--out "$out_bitstream_path"

if [ $? -ne 0 ]; then
	echo "Failed to update data memory"
	exit 1
fi

echo "-------------------------------------"
echo "Instruction RAM has been updated"
echo "Success to generate the new bitstream"
echo "-------------------------------------"


find . -name "*.log" | xargs rm
find . -name "*.jou" | xargs rm

echo " "
