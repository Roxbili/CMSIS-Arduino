#  CMSIS-Arduino
CMSIS version: 5.8.0  
CMSIS-DSP verion: 1.9.0  
CMSIS-NN version: 7.0.0  

## How to build CMSIS-DSP library?
```bash
cd DSP
sh build_library.sh {CMSIS_PATH} {CMSIS_VERSION}

# example
# sh build_library.sh CMSIS_5-5.8.0 5.8.0
```

## How to build CMSIS-NN library?
```bash
cd NN
sh build_library.sh {CMSIS_PATH} {CMSIS_VERSION}

# example
# sh build_library.sh CMSIS_5-5.8.0 5.8.0
```

## Load .zip library in Arduino IDE
In the Arduino IDE, navigate to Sketch > Include Library > Add .ZIP Library.