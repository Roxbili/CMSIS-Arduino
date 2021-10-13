#!/bin/bash
set -e  # if error, exit

CMSIS_PATH=$1
CMSIS_NN_PATH="${CMSIS_PATH}/CMSIS/NN"
DST_PATH="src"
VERSION=$2

echo "CMSIS path is ${CMSIS_PATH}"
# echo "CMSIS-NN path is ${CMSIS_NN_PATH}"
echo "CMSIS-NN version is ${VERSION}"

# remove old src directory and create a new one
if [ -d $DST_PATH ]; then
    rm -rf $DST_PATH
    echo "remove old src directory"
fi
mkdir $DST_PATH

# copy include file to src
cp ${CMSIS_NN_PATH}/Include/* src

# copy all operator directories to src
cp -r ${CMSIS_NN_PATH}/Source/* src

# create .properties file
cat > library.properties <<EOF
name=CMSIS-NN
version=${VERSION}
author=Roxbili
maintainer=stm32duino
sentence=CMSIS-NN library compatible with Arduino_Core_STM32
paragraph=Includes the CMSIS-NN code for the STM32Duino core
category=Data Processing
url=None
includes=arm_nnfunctions.h
depends=CMSIS DSP
EOF

# remove old .zip file and create a new one
if [ -a CMSIS_NN.zip ]; then
    rm CMSIS_NN.zip
    echo "remove old CMSIS_NN.zip file"
fi
zip -q -r CMSIS_NN.zip src/ examples/ library.properties
echo "create .zip library file successfully"