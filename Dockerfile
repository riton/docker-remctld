FROM ubuntu:18.04
MAINTAINER Remi Ferrand <remi.ferrand@cc.in2p3.fr>

ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE_PRINCIPAL "remctld"
ENV REMCTLD_CONFIG "/config/remctl.conf"
ENV KRB5_KTNAME "/config/krb5.keytab"
ENV KRB5_CONFIG "/config/krb5.conf"
ENV KRB5_REALM "EXAMPLE.ORG"

RUN apt-get update && \
    apt-get -y install libnet-remctl-perl python-remctl remctl-server ruby-remctl remctl-client \
    krb5-user

# Use dumb-init as PID1
ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 /usr/sbin/init
RUN chmod +x /usr/sbin/init

ADD init.sh /init
RUN chmod +x /init

ADD krb5.conf ${KRB5_CONFIG}
RUN sed -i -e "s/_REALM_/${KRB5_REALM}/g" ${KRB5_CONFIG}

RUN mkdir -p /config /config/conf.d /config/acl && \
    echo "include /config/conf.d" > ${REMCTLD_CONFIG}

VOLUME /config

ENTRYPOINT ["/usr/sbin/init"]
CMD [ "/init" ]

EXPOSE 4373
