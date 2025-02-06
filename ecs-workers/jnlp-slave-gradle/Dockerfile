FROM jenkinsci/jnlp-slave
LABEL author="Ruiyang Ding"

USER root

RUN apt update \
&& wget https://services.gradle.org/distributions/gradle-6.2-bin.zip -P /tmp \
&& unzip -d /opt/gradle /tmp/gradle-*.zip\
&& ls /opt/gradle/gradle-*
ENV GRADLE_HOME=/opt/gradle/gradle-6.2
ENV PATH=$PATH:$GRADLE_HOME/bin
USER jenkins

ENTRYPOINT ["jenkins-agent"]