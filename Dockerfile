FROM alpine:3.19.0@sha256:51b67269f354137895d43f3b3d810bfacd3945438e94dc5ac55fdac340352f48

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
