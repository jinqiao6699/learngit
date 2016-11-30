JAVA_HOME=/home/develop/java
export JAVA_HOME

CATALINA_HOME=/home/develop/d01/tomcat
CATALINA_BASE=${CATALINA_HOME}

export CATALINA_HOME
export CATALINA_BASE

cd ${CATALINA_BASE}
ps -ef | grep java | grep "catalina.base=${CATALINA_BASE} " | grep -v grep > tmp.txt
echo "---tomcat process:"
cat tmp.txt
pid=$(awk '{print $2}' tmp.txt)
if [ ! -z "$pid" ]
then
	echo "---stop tomcat process: $pid"
	kill -9 $pid
fi


if [ -d ${CATALINA_BASE}/conf/Catalina ]
then
        rm -fR ${CATALINA_BASE}/conf/Catalina
fi

if [ -d ${CATALINA_BASE}/work ]
then
        rm -fR ${CATALINA_BASE}/work
fi

if [ -f ${CATALINA_BASE}/logs/catalina.out ]
then
        rm -f ${CATALINA_BASE}/logs/catalina.out
fi

CLASSPATH=${JAVA_HOME}/lib/tools.jar:${CATALINA_HOME}/bin/bootstrap.jar:${CATALINA_HOME}/bin/tomcat-juli.jar
cd ${CATALINA_BASE}

nohup ${JAVA_HOME}/bin/java -Xmx1024m \
	-classpath $CLASSPATH \
	-Dcatalina.home=${CATALINA_HOME} -Dcatalina.base=${CATALINA_BASE} \
	org.apache.catalina.startup.Bootstrap > ${CATALINA_BASE}/logs/catalina.out 2>&1 &
