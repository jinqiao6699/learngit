#!/bin/sh
#print hello world in the console window 
a=$zzz
echo "Hi,${a}s"
if [ -n "$a" ];then 
	echo "qiaozhang"
else
	echo "zhangqiao"
fi

echo "请输入[y|n]:"
read name
if [ "$name" == "y" ]; then
	echo "您确定了！！！"
else
	echo "你否认了。。。"
fi