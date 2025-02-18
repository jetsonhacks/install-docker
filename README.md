# install-docker
Install Docker on a JetPack 6 machine

One of the changes from the previous version of JetPack versus JetPack 6 is that the SDK Manager does not install Docker by default. The SD card install for a Jetson Orin Nano incudes Docker, but host installs do not. These convenience scripts install Docker and configure it for use on the Jetson.

These scripts install Docker on the rootfs, and are meant for systems that run from a SSD. On a Jetson Orin Nano Developer Kit, if you want to use your SSD strictly as a separate data store and boot from the SD card, do not use these scripts. Instead see: [Tips - SSD + Docker](https://www.jetson-ai-lab.com/tips_ssd-docker.html) on the Jetson AI Lab website.


## Core Installation
 Install nv-container and Docker on the rootfs
 ```bash
 sudo bash ./install_nvidia_docker_core.sh
 ```

## Configuration
Configure the Jetson to run Docker and take advantage of NVIDIA runtime
```bash
sudo bash ./configure_nvidia_docker.sh
```

## Release Notes
### February 2025
* Initial Release

Modified scripts from: [Jetson AI Lab - Tips - SSD + Docker](https://www.jetson-ai-lab.com/tips_ssd-docker.html)
