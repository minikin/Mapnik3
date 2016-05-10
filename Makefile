XCODE_TOOLCHAIN = $(shell xcode-select --print-path)/Toolchains/XcodeDefault.xctoolchain
IOS_PLATFORM ?= iphoneos

# Pick latest SDK in the directory
IOS_SDK = $(shell xcrun -sdk ${IOS_PLATFORM} -show-sdk-path)

all:
	mkdir -p fat/lib
	mkdir -p fat/include
	
	# Copy includes
	cp -R arm7/include/ fat/include
	
	# Make fat libraries for all architectures
	for file in arm7/lib/*.a; \
		do name=`basename $$file .a`; \
		${XCODE_TOOLCHAIN}/usr/bin/lipo -create \
			arm7/lib/$$name.a \
			arm64/lib/$$name.a \
			-output fat/lib/$$name.a \
		; \
		done;
	echo "Making fat libs"
