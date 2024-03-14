# Docker for Android SDK 34

Docker for Android SDK 34 with preinstalled build tools and emulator image

> Edit from [mindrunner/docker-android-sdk](https://github.com/mindrunner/docker-android-sdk)

**Installed Packages**

```bash
# sdkmanager --list
  Path                                        | Version | Description                                | Location
  -------                                     | ------- | -------                                    | -------
  build-tools;34.0.0                          | 34.0.0  | Android SDK Build-Tools 34.0.0             | build-tools/34.0.0/
  cmdline-tools;latest                        | 9.0     | Android SDK Command-line Tools (latest)    | cmdline-tools/latest/
  emulator                                    | 34.1.19 | Android Emulator                           | emulator/
  platform-tools                              | 35.0.0  | Android SDK Platform-Tools                 | platform-tools/
  platforms;android-34                        | 3       | Android SDK Platform 34                    | platforms/android-34/
  system-images;android-34;google_apis;x86_64 | 12      | Google APIs Intel x86 Atom_64 System Image | system-images/android-34/google_apis/x86_64/
```

**Usage**

- Interactive way
  ```bash
  # check installed packages
  $ make packages
  # create and run emulator
  $ make bash-interactive # Or with `make bash-interactive-network-host` to be able to connect the emulator with "adb"
  $ avdmanager create avd -n first_avd --abi google_apis/x86_64 -k "system-images;android-34;google_apis;x86_64"
  $ press ok
  $ emulator -avd first_avd -no-window -no-audio &
  $ press ctrl + c to hide mssages
  $ adb devices
  # You can also run other Android platform tools, which are all added to the PATH environment variable
  ```

  If you are running the exemple with  `make bash-interactive-network-host`, you will have the process `adb -L tcp:5037 fork-server server --reply-fd 4` on your host (type `ps aux` on another bash)
  You could use [`scrcpy`](https://github.com/Genymobile/scrcpy) to do a screencast of the emulator.

- Non-interactive way
  ```bash
  # check installed packages
  $ make packages
  # list existing emulators
  $ make ls-emul
  # You can also run other Android platform tools, which are all added to the PATH environment variable
  ```