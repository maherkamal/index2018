FROM tomcat:8.5
MAINTAINER Maher Kamal

EXPOSE 8080

ENV PROJ_NAME="jfw"
ENV db_user="jfw"
ENV db_password="jfw"
ENV db_schema="jfw"
ENV db_type="H2"
ENV db_driver="org.h2.Driver"
ENV db_url="jdbc:h2:file:~/db;MODE=Oracle;AUTO_SERVER=TRUE;MVCC=true;LOCK_TIMEOUT=5000"
ENV db_validation_query="SELECT 1 FROM DUAL"
ENV db_dialect="org.hibernate.dialect.H2Dialect"
ENV db_check_query="SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES"
ENV PATH="$JAVA_HOME/bin:$PATH"


RUN apt-get install unzip

ADD https://jfrog:jfrogP%40ssw0rd@artifactory.psdevelop.com/artifactory/PS-Releases/com/progressoft/jfw/core-server/jfw-latest/core-server-jfw-latest.war /usr/local/tomcat/JFW.war
WORKDIR "/usr/local/tomcat"
RUN unzip JFW.war -d webapps/JFW
RUN rm JFW.war
WORKDIR "/usr/local/tomcat/webapps/JFW/WEB-INF/lib"
RUN java -jar initializer-jfw-latest.jar
WORKDIR "/usr/local/tomcat/bin"
