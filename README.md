## Virt-RC System  

Virt-RC(*Virtual but Real Career*) system describes my career more clearly. It's kind of developer's note or companion system of the resume.   
This system consists of two parts - QEMU (*virtual device*) and Linux ARM Guest OS (*virtual driver and initramfs*).
QEMU and kernel are built based on ARM AARCH64. Buildroot is used for creating initramfs which includes the web server, 'lighttpd'.  

## How to Get Image  

Distribution channel is Docker. Please refer to the [installation page](https://docs.docker.com/engine/installation/linux/ubuntulinux/) if not installed.  
The virt-rc system requires building not only QEMU but also kernel, 
so docker is a good option to release new built binaries like a snapshot.  
You can pull docker image from docker hub.  

	$ docker pull virtrc/latest

This image includes built binaries and shell script file.  

Alternatively, if you have free time, then you can also try to build docker image manually using Dockerfile. 
Please check it [here](https://github.com/milokim/virt-rc/blob/master/docker/Dockerfile).  

	$ docker build -t virtrc/latest .

## How to Run Virt-RC  

Before you run virt-rc system, you need to execute docker first.  
Please type commands below. (Or you can run this [script](https://github.com/milokim/virt-rc/blob/master/docker/run_docker.sh).) 

	$ xhost local:root
	$ docker run -it \
	    --net host \
	    -v /tmp/.X11-unix:/tmp/.X11-unix \
	    -e DISPLAY=unix$DISPLAY \
	    virtrc/latest

Welcome! You just ran a container. It's time to go inside and take a look :)  
Please execute the shell script below.  

	root@milo-dev:/home/virtrc# ./run_virtrc.sh

This command runs QEMU for ARM aarch64 emulation. You can login as 'root' without password.  

	** VIRT-RC SYSTEM **
	buildroot login: root

Now, you are in ARM system. Let's move to the sysfs of virt-rc device.  

	# cd /sys/devices/platform/b000000.virt_rc/	
	# cat career
	drivers android mainline qemu hw

Please select category which you're interested in. You can check the details by writing a value like  

	# echo "drivers" > career

Then, you can see the web page. You can type other values such like 'android', 'mainline', 'qemu' and 'hw'.

To quit the virt-rc system, press ctrl + a and c, then type 'quit' in (qemu) console. 
You need additional command - 'exit' to escape docker image.
