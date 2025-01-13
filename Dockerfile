FROM alpine:3.21.2@sha256:56fa17d2a7e7f168a043a2712e63aed1f8543aeafdcee47c58dcffe38ed51099

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
