# install-docker
Install Docker on a JetPack 6 machine

One of the changes from the previous version of JetPack versus JetPack 6 is that the SDK Manager does not install Docker by default. The SD card install for a Jetson Orin Nano incudes Docker, but host installs do not. These convenience scripts install Docker and configure it for use on the Jetson.

These scripts install Docker on the rootfs, and are meant for systems that run from a SSD. On a Jetson Orin Nano Developer Kit, if you want to use your SSD strictly as a separate data store and boot from the SD card, do not use these scripts. Instead see: [Tips - SSD + Docker](https://www.jetson-ai-lab.com/tips_ssd-docker.html) on the Jetson AI Lab website.


## Core Installation
Install nv-container and Docker on the rootfs
```bash
bash ./install_nvidia_docker.sh
```

## Configuration
Configure the Jetson to run Docker and take advantage of NVIDIA runtime
```bash
bash ./configure_nvidia_docker.sh
```
## Downgrade Docker
An issue with Docker 28.0.0 (released 2/20/2025) requires changes to the kernel which are not implemented in the current Jetson 6.2 release. If you have Docker installed, and after an apt upgrade the Docker daemon will not run, you can downgrade to Docker 27.5.1 using the downgrade_docker.sh script:
```
bash ./downgrade_docker.sh
```
Docker is downgraded to 27.5.1 and the packages are marked hold so that apt upgrade will not upgrade them automatically.


## Release Notes
### February 22, 2025
An issue with Docker 28.0.0 (released 2/20/2025) requires changes to the kernel which are not implemented in the current Jetson 6.2 release:
```
CONFIG_IP_SET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_NETFILTER_XT_SET=m
```
The install_nvidia_docker.sh script incorporates the current work around which is to downgrade to Docker 27.5.1. Also, Docker is marked hold so that apt upgrade doesn't inadvertently upgrade the package.
Apparently the settings are forward in the Ubuntu 24.04, and are not implemented in the Jetson 22.04 derived OS.
  
### February 2025
* Initial Release
* Tested on NVIDIA Jetson Orin Nano Super Developer Kit

Modified scripts from: [Jetson AI Lab - Tips - SSD + Docker](https://www.jetson-ai-lab.com/tips_ssd-docker.html)
