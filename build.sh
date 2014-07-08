export CROSS_COMPILE="$HOME/sm-arm-eabi-4.9/bin/arm-eabi-"
KERNEL_DIRECTORY="$HOME/flo-sm"
ANYKERNEL_DIRECTORY="$HOME/anykernel_msm"

if [[ "$1" =~ "cm" || "$1" =~ "CM" ]] ; then
git checkout sm-4.4-cm
zipfile="franco.Kernel-SaberMod-r17-CM.zip"
else
git checkout sm-4.4
zipfile="franco.Kernel-SaberMod-r17.zip"
fi


cd $ANYKERNEL_DIRECTORY
git checkout flo

cd $KERNEL_DIRECTORY

if [ -f zip/$zipfile ] ; then
rm -rf zip/*
fi

make franco_defconfig
make -j16

cd $ANYKERNEL_DIRECTORY
cp -r * $KERNEL_DIRECTORY/zip/
cd $KERNEL_DIRECTORY
cp arch/arm/boot/zImage zip/tmp/anykernel

echo "making zip file"
 
cd zip/
rm -f *.zip
zip -r $zipfile *
rm -f /tmp/*.zip
cp *.zip /tmp
