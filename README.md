## Virt-RC System  

Virt-RC(*Virtual but Real Career*) system describes my career systemically.  
This system consists of two parts - QEMU (*virtual device*) and Linux ARM Guest OS (*virtual driver and initramfs*).
QEMU and kernel are built based on ARM AARCH64. Buildroot is used for creating initramfs which includes the web server, 'lighttpd'.  

## How to Get Image  

Distribution channel is Docker.  
The virt-rc system requires not only QEMU modification but also kernel modification, 
so Docker is a good option to release new built binaries.  

You can also build your Docker image using virt-rc Dockerfile. Please check the docker file here.

## How to Run Virt-RC  

	$ ./run_docker.sh

Then, prebuilt ubuntu image runs. You can run QEMU by using command below.  

	root@milo-dev:/home/virtrc# ./run_virtrc.sh

This command runs QEMU for ARM aarch64 emulation.  
You can login as root without password.  

	buildroot loging: root

Please move to the sysfs of virt-rc device.  

	# cd /sys/devices/platform/b000000.virt_rc/	
	# cat career
	drivers android mainline qemu hw

You can check the details by writing a value like  

	# echo "drivers" > career
	# echo "android" > career

Then, you can see the web page.

To quit the virt-rc system, press ctrl + a and c, then type 'quit' in (qemu) console. You need additional command - 'exit' to escape docker image.
