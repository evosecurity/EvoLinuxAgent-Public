# Evo Linux Agent

> All instructions are under assumption of the repo being cloned on your target machine.

## Install Guide
Installing the Evo Linux Agent will take a couple steps, please follow them carefully as linux is very sensitive with authentication.

### Building
You can build from source using CMake. Example listed below<br>
```shell
mkdir -p build
```
```shell
cmake -B build
```
```shell
cmake --build build
```

Once CMake is finished compiling, you should have a `libevo_commonlogin.so` shared object in `build/`

### Installing
Installing is as simple as copying the built shared object into your shared system library directory, for this example this is a x86 machine. Keep in mind the directory name might change for your architecture but it will still be in the same relative location.
```shell
sudo cp build/libevo_commonlogin.so /lib/x86_64-linux-gnu/pam_evo_common.so
```

### Configuration Guide
Now that we installed the Evo module. We need to configure some settings to match our environment. Go ahead and run the following commands.
```shell
mkdir -p /etc/evosecurity.d
```
```shell
echo -e "[api]\naccess_token=\nsecret=\nenvironment_url=\ndirectory=\n" | sudo tee /etc/evosecurity.d/config.ini
```

Now we can open the config file we just made with our favorite editor at `/etc/evosecurity.d/config.ini`.<br>
The boiler plate should be there for you from the echo command we just ran. Go ahead and fill out your config with it's appropriate values.

### Setting up PAM modules to use Evo.
PAM works in a way called modules. Modules are certain aspects of the system that PAM may control based off the configuration file and which module may be loaded for each action. We're going to create a common file for evo to be able to include it in any PAM module.
Go ahead and use your favorite editor and open up `/etc/pam.d/evo_common`
<br>
In that file we're going to put
```sh
auth  sufficient  pam_evo_common.so
```
Now we can setup our PAM module to use the Evo authenticator. For this example we will edit `/etc/pam.d/sshd` to override SSH authentication. You may run `ls /etc/pam.d` to see what other modules linux may provide you to edit with.
<br>
Now that we've opened up `/etc/pam.d/sshd` with our favorite editor, we can go ahead and go to the top of the file and add
```sh
@include evo_common
```

> Note: There is no services to restart when editing PAM. It's automatically reloaded on edits.

### Allowing users to login with Evo
As per the beta version, a dedicated user must be created before using them with Evo. We're going to name our user `bob`
```shell
sudo adduser bob
```
Go ahead and fill out everything it asks for our new member "bob". The password will be used as a fallback case in the event the Evo authentication process denied the user access.
<br>
<br>
We can now SSH into the machine as `bob`. You will be asked for the E-Mail for the initial login, the password, and then the One Time Code or to approve a push notification assuming the credentials are correct.