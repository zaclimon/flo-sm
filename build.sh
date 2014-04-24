#!/bin/bash

RAMDISK="boot.img-ramdisk"

if [ $# -gt 0 ]; then
echo $1 > .version
echo $1
fi
 
if [ $# -gt 1 ]; then
RAMDISK="boot.img-ramdisk-deb"
echo $2
echo $RAMDISK
fi

time make -j16
 
cp arch/arm/boot/zImage ../ramdisk_flo/
 
cd ../ramdisk_flo/
 
echo "making ramdisk"
./mkbootfs $RAMDISK | gzip > ramdisk.gz
echo "making boot image"
./mkbootimg --kernel zImage --cmdline 'console=ttyHSL0,115200,n8 androidboot.hardware=flo user_debug=31 msm_rtb.filter=0x3F ehci-hcd.park=3' --base 0x80200000 --pagesize 2048 --ramdisk_offset 0x02000000 --ramdisk ramdisk.gz --output ../flo/boot.img
 
rm -rf ramdisk.gz
rm -rf zImage

cd ../flo/

zipfile="franco.Kernel-nightly.zip"
echo "making zip file"
cp boot.img zip/

rm -rf ../ramdisk_flo/boot.img
 
cd zip/
rm -f *.zip
zip -r $zipfile *
rm -f /tmp/*.zip
cp *.zip /tmp
