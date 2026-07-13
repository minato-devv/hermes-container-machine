# Hermes Agent in a container machine

Why container machine:
* persistent filesystem
* run and manage background services
* isolation of a VM
* seamless booting and shut down
* custom `/sbin/init`
* automatic user creation
* choice of mounting entire home directory
* OCI images for custom setups

Choice base image: **`debian:bookworm-slim`**.

`alpine` is problematic for this use case. `ubuntu` is slightly larger than `debian`, but still completely viable.

Choice `init` system: **`runit`** with **`rnuit-init`** for linking to `/sbin/init`. 

`systemd`/`OpenRC` is opt-out with hardware checks, requiring a need to mask and strip them beforehand; since we are in a container, `systemd`/`OpenRC` is too bloated for this circumstance, `runit` is simple, light, and efficient.

Hermes on Linux minimally requires these run the installation script:
* `git`
* `curl` (consequently, `ca-certificates`)
* `xz-utils`

Additional packages:

To minimize attack surface, `sudo` is not installed, and thus browser automation will not be set up; this setup is headless, no GUI or desktop app (requires `build-essential` on Debian-based distros).

Official Hermes documentation states that `ripgrep` and `ffmpeg` are automatically installed if not detected, however, from experience this does not always work, so install them manually.

Final + minimal image:

```Containerfile
FROM debian:bookworm-slim

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	git curl ca-certificates ffmpeg ripgrep xz-utils runit runit-init && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
```

Build the image:

```bash
container build -t debian:hermes --file ./Containerfile .
```

Create and configure the machine:

```bash
container machine create --home-mount=none --name <machine_name> debian:hermes
container machine set -n <machine_name> cpus=2 memory=4G # Hermes documentation recommend these minimums
container machine set-default <machine_name>
container machine stop # resources take action after a reboot
container machine run
```

Alternatively, you can use the [`install.sh`](install.sh) script provided.

Now running in a login shell, installation is a curl command:
```bash
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash -s -- --skip-browser
```
