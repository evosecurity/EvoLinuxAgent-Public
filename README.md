# Evo Linux Agent

## Warning

This is beta software and should not be used in production systems. By installing this software, you agree that Evo is not liable for any problems that may arise from its use.

## Dependencies

Required dependencies:

```shell
sudo apt install build-essential libpam0g-dev autoconf automake libtool libssl-dev libmxml-dev
```

## Installation

### Building from Source

```shell
./autogen.sh && \
./configure && \
make && \
sudo make install
```

### Configuration

1. Edit `/etc/evosecurity.d/config.ini`:

```ini
[api]
access_token=   # Your access token
secret=         # Your secret key
environment_url= # Your environment URL
directory=      # Your directory
```

2. Configure SSH authentication by editing `/etc/ssh/sshd_config`:

```shell
ChallengeResponseAuthentication yes
GSSAPIAuthentication no
PasswordAuthentication no
KbdInteractiveAuthentication yes
```

3. Restart SSH service:

```shell
sudo systemctl restart sshd
```

### User Setup

1. Create a new user:

```shell
sudo adduser <username>
```

2. Enable Evo authentication by editing `/etc/pam.d/sshd`:

```sh
@include evo_common
```

### Failsafe Access

A temporary failsafe user named `user` is available to bypass MFA login methods during beta testing. Note that you must create an underlying user named `user` to enable this functionality.

### Uninstallation

```shell
sudo make uninstall
```

> Note: Manual cleanup of PAM configuration files may be required.

### Advanced Configuration

The following configure options are available:

- `--with-pam-dir=DIR`: Directory to install PAM modules (default: /lib/security)
- `--with-pam-config-dir=DIR`: Directory to install PAM configuration (default: /etc/pam.d)
