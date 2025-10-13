FROM alpine:3.22.2@sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412

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
