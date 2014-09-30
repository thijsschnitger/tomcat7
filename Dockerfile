FROM thijsschnitger/oracle-java
MAINTAINER Thijs Schnitger <thijs.schnitger@trifork.nl>

ENV TOMCAT_MAJOR_VERSION 7
ENV TOMCAT_MINOR_VERSION 0.55

# INSTALL TOMCAT
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MAJOR_VERSION}.${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MAJOR_VERSION}.${TOMCAT_MINOR_VERSION}.tar.gz \
 && wget -qO- https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MAJOR_VERSION}.${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MAJOR_VERSION}.${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - \
 && tar zxf apache-tomcat-*.tar.gz \
 && rm apache-tomcat-*.tar.gz \
 && mv apache-tomcat* /opt/tomcat 
# && rm -rf /opt/tomcat/webapps/*

# Add Tomcat User
RUN adduser --system --group --shell /bin/bash tomcat \
 && chown -R tomcat.tomcat /opt/tomcat

USER tomcat

EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh","run"]

