# ubuntu for `systemd`

This Dockerfile is from apple's example in `docs/container-machine.md`, in addition to the required packages:

```Dockerfile
FROM ubuntu:24.04

ENV container container

RUN apt-get update && \
    apt-get install -y \
    dbus systemd openssh-server xz-utils curl ripgrep fd-find sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    yes | unminimize

RUN >/etc/machine-id
RUN >/var/lib/dbus/machine-id

RUN systemctl set-default multi-user.target
RUN systemctl mask \
      dev-hugepages.mount \
      sys-fs-fuse-connections.mount \
      systemd-update-utmp.service \
      systemd-tmpfiles-setup.service \
      console-getty.service
RUN systemctl disable \
      networkd-dispatcher.service

RUN sed -i -e 's/^AcceptEnv LANG LC_\*$/#AcceptEnv LANG LC_*/' /etc/ssh/sshd_config
```

## Notes:
* removal of `openssh-server` and the last `sed` command will not allow the machine to boot due to lack of `/sbin/init` for some mysterious reason
