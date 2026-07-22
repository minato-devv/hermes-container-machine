# Hermes Agent in a container machine

Why container machine:

* persistent filesystem
* run and manage background services
* custom `/sbin/init`
* automatic user mirroring
* choice of mounting entire home directory

Take your pick:

* [debian:bookworm-slim](debian/)
* [ubuntu:24.04](ubuntu/)

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

```bash
git clone https://github.com/minato-devv/hermes-container-machine.git
cd hermes-container-machine
chmod +x install.sh

# debian
./install.sh debian debian:hermes debian
# ubuntu
./install.sh ubuntu ubuntu:hermes ubuntu
```

Once in its interactive shell environment, install Hermes:

```bash
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash -s -- --skip-browser
```
