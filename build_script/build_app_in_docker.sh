#!/bin/bash

 docker run \
  -it \
  -v /home/kronusol/StudioProjects/mobile_wash_control/:/src \
  -v ./out:/out \
  build_mobile_wash_control