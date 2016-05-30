# Makefile for Perfect Server

TARGET = MySQL
OS = $(shell uname)

MODULE_NAME = MySQL
Linux_INSTALL_PATH = /usr/local/lib
Darwin_INSTALL_PATH = /Library/Frameworks
SWIFTC = /home/kinfey/Dev/swift-2.2-RELEASE-ubuntu15.10/usr/bin/swift
SWIFTC_FLAGS = -frontend -c -module-cache-path $(MODULE_CACHE_PATH) -emit-module -I /usr/local/lib -I ../../PerfectLib/linked/LibEvent \
	-I ../../PerfectLib/linked/OpenSSL_Linux -I ../../PerfectLib/linked/ICU -I ../../PerfectLib/linked/SQLite3 -I ../../PerfectLib/linked/LinuxBridge -I ../../PerfectLib/linked/cURL_Linux \
	-I ./linked/libmysqlclient
MODULE_CACHE_PATH = /tmp/modulecache
Linux_SHLIB_PATH = -L/home/kinfey/Dev/swift-2.2-RELEASE-ubuntu15.10/usr/lib/swift/linux
SHLIB_PATH = $($(OS)_SHLIB_PATH)

INSTALL_PATH = $($(OS)_INSTALL_PATH)
LFLAGS = $(SHLIB_PATH) -luuid -lswiftCore -lswiftGlibc /usr/local/lib/PerfectLib.so -lmysqlclient -shared

all: $(TARGET)


install:
	ln -sf `pwd`/$(MODULE_NAME).so /usr/local/lib/
	ln -sf `pwd`/$(MODULE_NAME).swiftmodule /usr/local/lib/
	ln -sf `pwd`/$(MODULE_NAME).swiftdoc /usr/local/lib/

modulecache:
	@mkdir -p $(MODULE_CACHE_PATH)

$(TARGET): $(TARGET).o
	clang++ $(LFLAGS) $< -o $@.so

$(TARGET).o: MySQL.swift
	$(SWIFTC) $(SWIFTC_FLAGS) MySQL.swift -o $@ -module-name $(TARGET) -emit-module-path $(TARGET).swiftmodule


clean:
	@rm *.o
