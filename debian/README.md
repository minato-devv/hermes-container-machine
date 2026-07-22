# debian with `runinit`

Choice `init` system: **`runit`** with **`rnuit-init`** for linking to `/sbin/init`. `runit` is simple, light, and efficient.`

```Dockerfile
FROM debian:bookworm-slim

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	git curl ca-certificates ffmpeg ripgrep xz-utils runit runit-init sudo && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
```
