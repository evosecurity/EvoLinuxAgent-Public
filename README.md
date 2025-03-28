# Evo Linux Agent
An Evo Elevated Access license is required for any authentication.

## Warning
This is beta software and should not be used in production systems. By installing this software, you agree that Evo is not liable for any problems that may arise from its use.

## Dependencies
Required dependencies:
```shell
build-essential libpam0g-dev autoconf automake libtool libssl1.1
```
These will be installed automatically as part of the installation script

## Installation

### Building from Source
```shell
sudo ./install.sh
```

### Configuration
1. Edit `/usr/local/etc/evosecurity.d/evopam.conf`:
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
If any of these are already set up by default on your system, be sure to change them, rather than just adding the setting.

3. Restart SSH service:
```shell
sudo systemctl restart sshd
```

### User Setup
1. Create a new user:
```shell
sudo adduser <username>
```

2. Enable Evo authentication by editing `/etc/pam.d/common-auth` with the following above any other PAM rules: 
```sh
@include evo_common
```

3. To change the email, you can edit the file at /home/{user}/.evoprofile


### Failsafe Access
To exclude users from EVO Authentication, put the name of the user on a new line of `/usr/local/etc/evosecurity.d/excludedusers`
By default, 'user' is included in this file.

### Uninstallation
```shell
sudo make uninstall
```
> Note: Manual cleanup of PAM configuration files may be required.

### Advanced Configuration
The following configure options are available:
- `--with-pam-dir=DIR`: Directory to install PAM modules (default: /lib/security)
- `--with-pam-config-dir=DIR`: Directory to install PAM configuration (default: /etc/pam.d)
