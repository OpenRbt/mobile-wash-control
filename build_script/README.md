# Prepare image
> docker build -t build_mobile_wash_control .

# Usage

1. Create directory for build output
2. Run builder to make linux build

>  docker run \
  -it \
  -v PATH_TO_APP_SOURCE_ROOT:/src \
  -v PATH_TO_OUTPUT_FOLDER:/out \
  build_mobile_wash_control

## Example

>  docker run \
  -it \
  -v /home/user/mobile_wash_control:/src \
  -v /home/user/build/:/out \
  build_mobile_wash_control