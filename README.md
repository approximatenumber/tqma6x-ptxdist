# PTXdist (2019.01.0) with compiled OSELAS toolchain (2018.02.0) based on Ubuntu 18 image.
Used to build ptdxdist OS for embedded platforms (originally created to build TQMA6x BSP).

## How to start

1. Build docker image

```
docker build -t ptxdist2019 ./
```

2. Download BSP for your platform
3. Go to BSP root directory.
3. Configure ptxdist to use your BSP configuration inside docker this image:

```bash
docker run -it --rm ptxdist2019 bash
# set platform 
ptxdist platform configs/platform..../platformconfig
# select ptxconfig
ptxdist select configs/platform..../ptxconfig
```

4. Build your BSP OS

```
ptxdist go
```
