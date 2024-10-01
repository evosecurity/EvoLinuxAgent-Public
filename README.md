
# Evo Linux Agent

## **Warning:** This is beta software and should not be used on production systems. By installing this software you agree that Evo is not liable for any problems that may arise from its use.

## Installation Guide

> All instructions assume that the repository has been cloned on your target machine.

Installing the Evo Linux Agent involves a few steps. Please follow them carefully, as Linux is sensitive with authentication settings.

### Building

To build from source using CMake, follow the example below:

```shell
mkdir -p build
cmake -B build
cmake --build build
```

After CMake finishes compiling, you should have a `libevo_commonlogin.so` shared object in the `build/` directory.

### Installing

To install, simply copy the built shared object into your system's shared library directory. Presently, the module will only compile on x86_64 machines.

```shell
sudo cp build/libevo_commonlogin.so /lib/x86_64-linux-gnu/pam_evo_common.so
```

### Configuration Guide

Now that we have installed the Evo module, we need to configure some settings to match our environment. Run the following commands:

```shell
mkdir -p /etc/evosecurity.d
echo -e "[api]\naccess_token=\nsecret=\nenvironment_url=\ndirectory=\n" | sudo tee /etc/evosecurity.d/config.ini
```

Now, open the configuration file we just created with your favorite editor at `/etc/evosecurity.d/config.ini`.

The boilerplate should be there from the `echo` command we just ran. Fill out the configuration file with the appropriate values.

### Setting Up PAM Modules to Use Evo

PAM (Pluggable Authentication Modules) operates through modules, which control certain aspects of the system's authentication process based on configuration files. We're going to create a common file for Evo so that it can be included in any PAM module.

Use your favorite editor to open `/etc/pam.d/evo_common`.

In that file, add:

```sh
auth  sufficient  pam_evo_common.so
```

Now, we can set up our PAM module to use the Evo authenticator. For this example, we will edit `/etc/pam.d/sshd` to override SSH authentication. You may run `ls /etc/pam.d` to see what other modules Linux provides for you to edit.

Open `/etc/pam.d/sshd` with your favorite editor, and at the top of the file, add:

```sh
@include evo_common
```

> **Note:** There are no services to restart when editing PAM; changes are automatically reloaded upon edits.

### Allowing Users to Log In with Evo

In the beta version, a dedicated user must be created before using Evo. We will name our user `bob`.

```shell
sudo adduser bob
```

Fill out the requested information for the new user "bob." The password will be used as a fallback in the event the Evo authentication process denies the user access.

We can now SSH into the machine as `bob`. You will be asked for the email for the initial login, the password, and then the one-time code or to approve a push notification, assuming the credentials are correct.
