#!/bin/sh

if [ $# -lt 2 ]
then
	echo "---usage: -v version"
	exit
fi
cd ~
while getopts "v:" OPT
do
	case $OPT in
	v)
		ver=$OPTARG
		echo "---deploy version: $ver"
	;;
	*)
		echo "---usage: -v version"
		exit
	;;
	esac
done

tomcat_dir=/home/wms/apache-tomcat-7.0.62

echo "---stop tomcat"
${tomcat_dir}/bin/shutdown.sh
sleep 3

echo "---backup"
cd ${tomcat_dir}/webapps
rm -f wms.*
tar cvf wms.tar wms
rm -fR wms

echo "---get war"
wget -O wms.war http://115.28.157.138:8060/wms/$ver/wms.war

echo "---start tomcat"
${tomcat_dir}/bin/startup.sh
