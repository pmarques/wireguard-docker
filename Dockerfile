FROM alpine:3.22.1@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1

VOLUME /etc/wireguard

COPY run.sh /

# Install WireGuard and dependencies
RUN apk add --no-cache \
	wireguard-tools \
	bind-tools \
	iptables \
	ip6tables \
	inotify-tools \
	net-tools \
	libqrencode \
	openresolv \
	procps \
	curl \
	iproute2 \
	tcpdump \
	iperf3

CMD [ "/run.sh" ]
