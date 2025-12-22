FROM alpine:3.23.2@sha256:865b95f46d98cf867a156fe4a135ad3fe50d2056aa3f25ed31662dff6da4eb62

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
