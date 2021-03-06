## Virt-RC System  

Virt-RC(*Virtual but Real Career*) system describes my career more clearly. It's kind of developer's note or companion system of the resume.   
This system consists of two parts - QEMU (*virtual device*) and Linux ARM Guest OS (*virtual driver and initramfs*).
QEMU and kernel are built based on ARM AARCH64. Buildroot is used for creating initramfs which includes the web server, 'lighttpd'.  

## How to Get a Prebuilt Image  

Distribution channel is Docker. Please refer to the [installation page](https://docs.docker.com/engine/installation/linux/ubuntulinux/) if not installed.  
The virt-rc system requires building not only QEMU but also kernel, 
so docker is a good option to release new built binaries as a snapshot.  

You can pull docker image from docker hub.  

	$ docker pull virtrc/latest

This image includes virt-rc binaries and shell script file. Please note that this repository is ubuntu-based.  

Alternatively, you may want to build docker image manually. Please use the [Dockerfile](https://github.com/milokim/virt-rc/blob/master/docker/Dockerfile) and build it.  
It takes much time to be completed. If you've already pulled the image, then please skip building the dockerfile.  

	$ docker build -t virtrc/latest .

## How to Run Virt-RC  

Before you run virt-rc system, you need to execute docker first.  
Please type commands below. (Or you can use the [script](https://github.com/milokim/virt-rc/blob/master/docker/run_docker.sh).) 

	$ xhost local:root
	$ docker run -it \
	    --net host \
	    -v /tmp/.X11-unix:/tmp/.X11-unix \
	    -e DISPLAY=unix$DISPLAY \
	    virtrc/latest

Welcome! You just ran a container. It's time to go inside and take a look :)  
Run virt-rc system by using the script.  

	root@milo-dev:/home/virtrc# ./run_virtrc.sh

This command runs QEMU for ARM aarch64 emulation. Please login as 'root' without password.  

	** VIRT-RC SYSTEM **
	buildroot login: root

	# uname -a
	Linux buildroot 4.3.0 #58 SMP Thu Feb 11 23:30:57 KST 2016 aarch64 GNU/Linux

Now, you are in ARM system. Let's move to the sysfs of virt-rc device.  

	# cd /sys/devices/platform/b000000.virt_rc/	
	# cat career
	drivers android mainline qemu hw

Please select a category which you're interested in.  

	# echo "drivers" > career

Then, you will see the web page. You can type other values such like 'android', 'mainline', 'qemu' and 'hw'.

To quit the virt-rc system, press ctrl + a and c, then type 'quit' in (qemu) console. 
You need additional command - 'exit' to escape docker image.  

## How It Works  

Whenever user (recruiter) requests the details of my career, virtual driver and device handle it. 
Virtual device opens the URL, then user can see my career page.  


![digram](https://github.com/milokim/virt-rc/blob/master/virtrc_diagram.png)


* Guest OS  
Kernel is ARM64. User-space is built from buildroot. Web server and some utilities are included in initramfs.  
The virt-rc driver requests the memory IO region and creates the sysfs named 'career' on initialization.  
As soon as a value is written to 'career', then virt-rc driver sends a command to virt-rc device in QEMU.  
This is memory map IO communication, so registers are implemented both in virtual driver and device.  

	Source code: [virt-rc driver](https://github.com/milokim/virt-rc/blob/master/kernel/0001-platform-Add-virt-rc-driver.patch)

* Host  
Whenever IO read/write operation is requested from the guest, QEMU virt-rc device handles the command.  
In case a command is for opening URL, then virt-rc device runs a web browser and request a URL.  
Then, web server in the guest responds through the virtual network.  

	Source code: [virt-rc device](https://github.com/milokim/virt-rc/blob/master/qemu/0001-hw-arm-aarch64-Add-virt-rc-device.patch)
