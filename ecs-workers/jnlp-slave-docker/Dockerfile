FROM jenkinsci/jnlp-slave
LABEL author="Ruiyang Ding"

USER root

RUN apt update \
&& apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg2 \
&& curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
&& add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
&& apt update\
&& apt install -y docker-ce
RUN gpasswd -a jenkins docker
USER jenkins

ENTRYPOINT ["jenkins-agent"]