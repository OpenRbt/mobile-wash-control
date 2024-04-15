#!/bin/bash

 cd ../
 docker run \
  -it \
  -v ./:/src \
  -v ./build_script/buid:/out \
  build_mobile_wash_control