#!/bin/sh
cd ~/product_hm_wms_plat

version=$1
echo "创建版本："+ $version
if [ ! -n "$version" ]; then
   echo "Please input version;usage: buildWms.sh v1.0"
   exit 0
fi
versionUrl=/home/develop/wmsProduct/$version
if [ -d $versionUrl ]; then
  echo -n "创建文件失败，版本文件已经存在,是否覆盖重新编译此版本[y|n]:"
  read name
  if [ "$name" == "y" ]; then
     mv $versionUrl /home/develop/wmsProduct/bak/
     echo "继续开始生成此版本war包，请稍候...."
  else
    exit 0
  fi
fi
mkdir -p $versionUrl
if [ ! -d "$versionUrl" ]; then
  echo "创建文件失败，请重新执行"
  exit 0
fi

echo "创建目录全地址"+ versionUrl


git pull
mvn clean
mvn install -Pproduct


cp /home/develop/product_hm_wms_plat/target/wms.war /home/develop/wmsProduct/$version/.
