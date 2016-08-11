FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive
RUN groupadd -r rabbitmq && useradd -r -d /var/lib/rabbitmq -m -g rabbitmq rabbitmq
RUN apt-get update
RUN apt-get -y install wget
RUN wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add -
RUN echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list
RUN apt-get -y --force-yes install rabbitmq-server


RUN /usr/sbin/rabbitmq-plugins enable rabbitmq_mqtt rabbitmq_stomp rabbitmq_management \ 
rabbitmq_management_agent rabbitmq_management_visualiser rabbitmq_federation rabbitmq_federation_management sockjs



ADD erlang.cookie  /var/lib/rabbitmq/.erlang.cookie
RUN chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
RUN chmod 400 /var/lib/rabbitmq/.erlang.cookie

RUN echo '[ { rabbit, [ { loopback_users, [ ] } ] } ].' > /etc/rabbitmq/rabbitmq.config
RUN chmod u+rw /etc/rabbitmq/rabbitmq.config


RUN mkdir /opt/rabbit

COPY rabbitcluster.sh /opt/rabbit/

RUN chmod a+x /opt/rabbit/rabbitcluster.sh



EXPOSE 5672
EXPOSE 15672
EXPOSE 25672
EXPOSE 4369

CMD /opt/rabbit/rabbitcluster.sh
