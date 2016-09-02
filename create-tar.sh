#!/bin/bash

#./create-tar.sh rootfs.tar.gz

ROOTFS=$1  #rootfs.tar.gz

rootfs_folder=$(basename $ROOTFS .tar.gz) #rootfs as a foldername
FINAL_RFS=final-rootfs # final rootfs creation folder name
FOLDER1=test1 #Dummy folder 1
FOLDER2=test2 # dummy folder 2

set -x

untar_rootfs()
{
    if [ "$ROOTFS" ==  rootfs*.tar.* ]; then
	echo $ROOTFS
	echo "Creating Rootfs directory"
	mkdir -p $rootfs_folder
	pushd $rootfs_folder
	tar -xvf ../$ROOTFS -C .
	popd
    fi
}


create_rootfs()
{
    pushd $rootfs_folder
    tar -zcf ../$FINAL_RFS.tar.gz *
    popd
}


integration_rootfs()
{
    cp -rpd test1 $rootfs_folder/somefolder
    cp -rpd test2 $rootfs_folder/somefolder
}

untar_rootfs
integration_rootfs
create_rootfs
