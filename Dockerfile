FROM ubuntu:14.04

RUN apt-get update

RUN apt-get install -y python-setuptools python-mysqldb python-dev build-essential mariadb-server-5.5 curl libffi-dev libssl-dev
RUN easy_install paste python-slugify jinja2 shortuuid py-bcrypt termcolor simplejson pyyaml pyopenssl

RUN curl https://userify.com/enterprise/userify-ssh-server.tar.gz | tar -zxC /opt/

RUN sed -i "s/^ *exit 0/# exit 0/" /etc/rc.local
RUN echo '/opt/userify-ssh-server/api.py | logger -p local3.info -t userify-ssh-server &' >> /etc/rc.local

ADD userify-ssh.service /usr/lib/systemd/system/userify-ssh.service

RUN groupadd --system userify
RUN useradd  --system -s /bin/false userify -g userify

RUN chown -R root:root /opt/userify-ssh-server/
RUN chmod -R 755 /opt/userify-ssh-server/
RUN chmod -R 700 /opt/userify-ssh-server/config.py

RUN cd /opt/userify-ssh-server && ./generate_ssl_key.sh

ADD license.json /opt/userify-ssh-server/license.json

RUN sed -i "s/>> THIS LINE WILL CAUSE AN ERROR. PLEASE DELETE ONLY AFTER MAKING SURE ALL OF THE ABOVE IS CORRECT <<//" /opt/userify-ssh-server/config.py

CMD sleep 15 && /opt/userify-ssh-server/api.py

EXPOSE 443
