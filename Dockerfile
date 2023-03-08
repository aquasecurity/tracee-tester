FROM debian:buster

COPY ./entrypoint.sh /entrypoint.sh
COPY ./install-deps.sh /install-deps.sh
COPY ./common /common
COPY ./x86_64 /x86_64
COPY ./aarch64 /aarch64

RUN ./install-deps.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
