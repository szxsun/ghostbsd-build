#!/bin/sh
#
# Copyright (c) 2011 GhostBSD
#
# See COPYING for licence terms.
#
# $GhostBSD$
# $Id: iso.sh,v 1.7 Thu Dec 15 18:08:31 AST 2011 Eric

set -e -u

if [ -z "${LOGFILE:-}" ]; then
    echo "This script can't run standalone."
    echo "Please use launch.sh to execute it."
    exit 1
fi

GHOSTBSD_LABEL=${GHOSTBSD_LABEL:-"GhostBSD"}

echo "#### Building bootable ISO image for ${ARCH} ####"

echo "Saving mtree structure..."
mtree -Pcp ${CLONEDIR} | bzip2 -9 > root.dist.bz2
mkdir -p ${CLONEDIR}/dist
mv root.dist.bz2 ${CLONEDIR}/dist/
echo "/dev/iso9660/`echo ${GHOSTBSD_LABEL} | tr '[:lower:]' '[:upper:]'` / cd9660 ro 0 0" > ${CLONEDIR}/etc/fstab
echo "proc /proc procfs rw 0 0" >> ${CLONEDIR}/etc/fstab
echo "linproc /compat/linux/proc linprocfs rw 0 0" >> ${CLONEDIR}/etc/fstab
cd ${CLONEDIR} && tar -cpzf ${CLONEDIR}/dist/etc.tgz etc

echo "### Running makefs. ###"
bootable="-o bootimage=i386;${CLONEDIR}/boot/cdboot -o no-emul-boot"
makefs -t cd9660 $bootable -o rockridge -o label=${GHOSTBSD_LABEL} ${ISOPATH} ${CLONEDIR}

echo "ISO created:"

# Make mdsums and sha256 for iso
cd /usr/obj
md5 `echo ${ISOPATH}|cut -d / -f4` >> /usr/obj/MD5SUM   
sha256 `echo ${ISOPATH}| cut -d / -f4` >> /usr/obj/SHA256SUM
cd -

# Preserve log files from /usr/obj${CURDIR} to /usr/obj${CURDIR}_${ARCH}
mkdir -p /usr/obj${CURDIR}_${ARCH}  
ls /usr/obj${CURDIR}/.*_* > ${BASEDIR}/tocopy

while read f ; do
cp -f $f /usr/obj${CURDIR}_${ARCH}/  
done < ${BASEDIR}/tocopy
mv /usr/obj${CURDIR}_${ARCH}/.tmp_iso /usr/obj${CURDIR}_${ARCH}/.done_iso 
rm -f ${BASEDIR}/tocopy

ls -lh ${ISOPATH}

cd ${LOCALDIR}