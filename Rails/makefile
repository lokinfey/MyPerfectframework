# Makefile for Perfect Server

TARGET = Rails
OS = $(shell uname)
RAILS_SRC = Rails/Utils/extension.swift Rails/Utils/Controller.swift Rails/Controllers/HomeController.swift Rails/Startup.swift
PERFECT_ROOT = ../PerfectLib
MYSQL_ROOT = ../Perfect/Connectors/MySQL
SWIFTC = /home/kinfey/Dev/swift-2.2-RELEASE-ubuntu15.10/usr/bin/swift
SWIFTC_FLAGS = -frontend -c -module-cache-path $(MODULE_CACHE_PATH) -emit-module -I /usr/local/lib -I $(PERFECT_ROOT)/linked/LibEvent \
	-I $(PERFECT_ROOT)/linked/OpenSSL_Linux -I $(PERFECT_ROOT)/linked/ICU -I $(PERFECT_ROOT)/linked/SQLite3 -I $(PERFECT_ROOT)/linked/LinuxBridge -I $(PERFECT_ROOT)/linked/cURL_Linux \
	-I $(MYSQL_ROOT)/linked/libmysqlclient
MODULE_CACHE_PATH = /tmp/modulecache
Linux_SHLIB_PATH = /home/kinfey/Dev/swift-2.2-RELEASE-ubuntu15.10/usr/lib/swift/linux
SHLIB_PATH = -L$($(OS)_SHLIB_PATH)
LFLAGS = $(SHLIB_PATH) -luuid -lswiftCore -lswiftGlibc /usr/local/lib/MySQL.so /usr/local/lib/PerfectLib.so -Xlinker -rpath -Xlinker $($(OS)_SHLIB_PATH) -shared

all: $(TARGET)
	
modulecache:
	@mkdir -p $(MODULE_CACHE_PATH)

$(TARGET): modulecache
	$(SWIFTC) $(SWIFTC_FLAGS) $(RAILS_SRC) -o $@.o -module-name $@ -emit-module-path $@.swiftmodule
	clang++ $(LFLAGS) $@.o -o $@.so

clean:
	@rm *.o