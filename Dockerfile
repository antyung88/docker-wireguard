FROM ubuntu
RUN apt install wireguard-tools -y
# Add main work dir to PATH
WORKDIR /scripts
ENV PATH="/scripts:${PATH}"
COPY genkeys /scripts
RUN chmod 755 /scripts/*
COPY run.sh /
RUN chmod +x /run.sh
CMD ["/run.sh"]
