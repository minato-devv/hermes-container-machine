# Hermes Agent in a container machine

Why container machine:
* persistent filesystem
* run and manage background services
* custom `/sbin/init`
* automatic user mirroring
* choice of mounting entire home directory

Choice base image: **`debian:bookworm-slim`**.

Choice `init` system: **`runit`** with **`rnuit-init`** for linking to `/sbin/init`. `runit` is simple, light, and efficient.`

## Requirements:

* macOS 26+
* [apple/container](https://github.com/apple/container.git)

At the very least, Hermes on Linux requires:
* `git`
* `curl` (consequently, `ca-certificates`)
* `xz-utils`

Additional packages (to be sure):

* `ripgrep`
* `fd-find`

## Setup

Minimal image:

```Containerfile
FROM debian:bookworm-slim

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	git curl ca-certificates ffmpeg ripgrep xz-utils runit runit-init sudo && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
```

Build the image:

```bash
container build -t debian:hermes --file ./Containerfile .
```

Create and configure the machine. We disable home-mount by default for isolation from personal files:

```bash
container machine create --home-mount=none --name <machine_name> --set-default --cpus 2 --memory 4G debian:hermes
container machine run
```

Alternatively, you can use the [`install.sh`](install.sh) script provided.

Now running in a login shell, installation of Hermes is simply one curl command:
```bash
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash -s -- --skip-browser
```
