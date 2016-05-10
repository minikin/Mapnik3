GENCCODE_ASSEMBLY_TYPE=-a gcc-darwin
SO=dylib
SOBJ=dylib
A=a
LIBPREFIX=lib
LIB_EXT_ORDER=.56.1.dylib
COMPILE=/usr/bin/clang -DU_ATTRIBUTE_DEPRECATED= -I/Users/dru/Downloads/mapnik-packaging-master/osx/out/packages/icu-arm64/source/common -I/Users/dru/Downloads/mapnik-packaging-master/osx/out/packages/icu-arm64/source/tools/tzcode/   -DU_ENABLE_DYLOAD=0 -DU_HAVE_ATOMIC=1  -I/Users/dru/Downloads/mapnik-packaging-master/osx/out/build-cpp11-libcpp-arm64-iphoneos64/include -DNDEBUG -O3 -arch arm64 -D_FILE_OFFSET_BITS=64 -miphoneos-version-min=9.3 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS9.3.sdk -Wno-invalid-source-encoding -Wno-cast-align -Wno-extended-offsetof -Wno-unknown-warning-option -Wno-long-long -Wno-unused-parameter -Wno-unused-but-set-variable -Wno-strict-prototypes -Wno-unused-variable -Wno-redundant-decls -Wno-return-type -Wno-uninitialized -Wno-unused-result -Wno-format -std=c99 -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings   -fno-common -c
LIBFLAGS=-I/Users/dru/Downloads/mapnik-packaging-master/osx/out/build-cpp11-libcpp-arm64-iphoneos64/include  -dynamic
GENLIB=/usr/bin/clang -dynamiclib -dynamic -I/Users/dru/Downloads/mapnik-packaging-master/osx/out/build-cpp11-libcpp-arm64-iphoneos64/include -DNDEBUG -O3 -arch arm64 -D_FILE_OFFSET_BITS=64 -miphoneos-version-min=9.3 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS9.3.sdk -Wno-invalid-source-encoding -Wno-cast-align -Wno-extended-offsetof -Wno-unknown-warning-option -Wno-long-long -Wno-unused-parameter -Wno-unused-but-set-variable -Wno-strict-prototypes -Wno-unused-variable -Wno-redundant-decls -Wno-return-type -Wno-uninitialized -Wno-unused-result -Wno-format -std=c99 -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings   -L/Users/dru/Downloads/mapnik-packaging-master/osx/out/build-cpp11-libcpp-arm64-iphoneos64/lib -O3 -arch arm64 -miphoneos-version-min=9.3 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS9.3.sdk -L/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS9.3.sdk/usr/lib -Wl,-search_paths_first  
LDICUDTFLAGS=
LD_SONAME=-Wl,-compatibility_version -Wl,56 -Wl,-current_version -Wl,56.1 -install_name
RPATH_FLAGS=
BIR_LDFLAGS=
AR=ar
ARFLAGS=r -c
RANLIB=ranlib
INSTALL_CMD=/usr/bin/install -c
