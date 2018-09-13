#!/bin/bash
#/usr/sbin/init &

/usr/sbin/glusterd -p /var/run/glusterd.pid --log-level INFO &

sleep 2s

echo "run init script"
mkdir /opt/gfsdata

x=1
while [ $x -le 1 ]
do
    gluster volume create gfs replica 3 glusterfs-0:/data/glusterfs glusterfs-1:/data/glusterfs glusterfs-2:/data/glusterfs force
	if [ $？ -eq 0 ];
	then
        	x=$(( $x + 1 ))
    else
           	echo "Other node not ready ,sleep 10s ........"
	fi

	sleep 10s
done
echo "mount GFS already finsihing...."


#gluster volume create gfs replica 3 glusterfs-0:/data/glusterfs glusterfs-1:/data/glusterfs glusterfs-2:/data/glusterfs force &
#gluster volume start gfs &
#mount -t glusterfs localhost:gfs /opt/gfsdata &

sleep inf