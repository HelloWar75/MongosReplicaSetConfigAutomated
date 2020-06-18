FROM mongo:latest
COPY init.sh /tmp/init.sh
CMD /tmp/init.sh
