FROM debian:bookworm-slim

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	git curl ca-certificates ffmpeg ripgrep xz-utils runit runit-init sudo && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
