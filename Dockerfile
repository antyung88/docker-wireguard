FROM alpine
RUN apk add --no-cache wireguard-tools bash
# Add main work dir to PATH
WORKDIR /scripts
ENV PATH="/scripts:${PATH}"
COPY genkeys /scripts
RUN chmod 755 /scripts/*
COPY run.sh /
RUN chmod +x /run.sh
CMD ["/run.sh"]
