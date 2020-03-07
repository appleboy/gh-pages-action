FROM appleboy/gh-pages:1.2.1-linux-amd64

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
