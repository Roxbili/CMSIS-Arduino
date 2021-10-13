#!/bin/bash
set -e  # if error, exit

CMSIS_PATH=$1
CMSIS_DSP_PATH="${CMSIS_PATH}/CMSIS/DSP"
DST_PATH="src"
VERSION=$2

echo "CMSIS path is ${CMSIS_PATH}"
echo "CMSIS-DSP version is ${VERSION}"

# remove old src directory and create a new one
if [ -d $DST_PATH ]; then
    rm -rf $DST_PATH
    echo "remove old src directory"
fi
mkdir $DST_PATH

# copy include file to src
cp -r ${CMSIS_DSP_PATH}/Include/* src
cp -r ${CMSIS_DSP_PATH}/PrivateInclude/* src

# copy all operator directories to src
cp -r ${CMSIS_DSP_PATH}/Source src

# remove all the {dir_name}.c to prevent link c files twice
# these two commands are important, make sure they are working correctly!
# this command comes from url: https://github.com/arduino-libraries/Arduino_CMSIS-DSP/blob/master/create_lib
find src/Source -type d ! -path src/Source | sed 's|src/Source/||g' | xargs -I {} sh -c 'rm src/Source/{}/{}*.c'
rm src/Source/TransformFunctions/arm_bitreversal2.c

# create .properties file
cat > library.properties <<EOF
name=CMSIS-DSP
version=${VERSION}
author=Roxbili
maintainer=stm32duino
sentence=CMSIS-DSP library compatible with Arduino_Core_STM32
paragraph=Includes the CMSIS-DSP code for the STM32Duino core
category=Data Processing
url=None
includes=arm_math.h
EOF

# remove old .zip file and create a new one
if [ -a CMSIS_DSP.zip ]; then
    rm CMSIS_DSP.zip
    echo "remove old CMSIS_DSP.zip file"
fi
zip -q -r CMSIS_DSP.zip src/ examples/ library.properties
echo "create CMSIS_DSP.zip library file successfully"