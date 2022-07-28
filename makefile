TARGET_MODULE:=simple-module
# If we are running by kernel building system
ifneq ($(KERNELRELEASE),)
  $(TARGET_MODULE)-objs := main.o device_file.o
  obj-m := $(TARGET_MODULE).o
# If we running without kernel build system
else
  BUILDSYSTEM_DIR:=/lib/modules/$(shell uname -r)/build
  PWD:=$(shell pwd)
all : 
# run kernel build system to make module
  $(MAKE) -C $(BUILDSYSTEM_DIR) M=$(PWD) modules
clean:
# run kernel build system to cleanup in current directory
  $(MAKE) -C $(BUILDSYSTEM_DIR) M=$(PWD) clean
load:
  insmod ./$(TARGET_MODULE).ko
unload:
  rmmod ./$(TARGET_MODULE).ko
endif 

// To build our first module, execute the make modules_prepare command from the folder
// To load the module, we have to execute the make load command from the source file folder. After this, the name of the driver is added to the /proc/modules file, while the device that the module registers is added to the /proc/devices file.

