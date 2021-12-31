ARG COTURN_VERSION=${COTURN_VERSION}
FROM coturn/coturn:${COTURN_VERSION}

COPY turnserver.conf /etc/turnserver.conf

COPY docker-entrypoint.sh /

USER root:root
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["--log-file=stdout", "--external-ip=$(detect-external-ip)"]

