#!/bin/sh

stop_dev()
{
  for i in mddevice pdevice ; do
      if [ -f "${BASEDIR}/$i" ]; then
          DEVICE=$(cat ${BASEDIR}/$i)
          if [ -c "/dev/${DEVICE}" ]; then
              umount -f /dev/${DEVICE}
              mdconfig -d -u ${DEVICE}
          fi
      fi
  done
}

stop_jail()
{
  JAILFS=$(echo ${BASEDIR} | cut -d / -f 3,3)
  jail_name=${JAILFS}${PACK_PROFILE}${ARCH}
  jailrun=$(jls | grep $jail_name | awk '{print $3}'| cut -d . -f2)
  if [ -n $jailrun ]; then
      service jail onestop $jail_name
  fi
}