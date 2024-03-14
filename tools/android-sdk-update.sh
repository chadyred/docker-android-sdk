#!/bin/bash

mkdir -p /opt/android-sdk-linux/bin/
cp /opt/tools/android-env.sh /opt/android-sdk-linux/bin/
source /opt/android-sdk-linux/bin/android-env.sh

built_in_sdk=1

echo $#

echo $1

if [ $# -ge 0 ] && [ "$1" == "lazy-dl" ]
then
    echo "Using Lazy Download Flavour"
    built_in_sdk=0
elif [ $# -ge 0 ] && [ "$1" == "built-in" ]
then
    echo "Using Built-In SDK Flavour"
    built_in_sdk=1
else
    echo "Please use either built-in or lazy-dl as parameter"
    exit 1
fi

cd ${ANDROID_HOME}
echo "Set ANDROID_HOME to ${ANDROID_HOME}"

if [ -f .android-sdk-bootstrapped ]
then
  echo "SDK Tools already bootstrapped. Skipping initial setup"
else
  rm -rf .android-sdk-bootstrapped
  echo "Bootstrapping SDK-Tools using the latest"
  wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O commandlinetools-linux.zip
  unzip commandlinetools-linux.zip
  mkdir latest && mv cmdline-tools/* latest/ && mv latest cmdline-tools/ # see https://developer.android.com/tools/sdkmanager
  touch .android-sdk-bootstrapped
fi

echo "Make sure repositories.cfg exists"
mkdir -p ~/.android/
touch ~/.android/repositories.cfg

echo "Copying Licences"
cp -rv /opt/licenses ${ANDROID_HOME}/licenses

echo "Copying Tools"
mkdir -p ${ANDROID_HOME}/bin
cp -v /opt/tools/*.sh ${ANDROID_HOME}/bin

echo "Installing packages"
if [ $built_in_sdk -eq 1 ]
then
    android-accept-licenses.sh "sdkmanager --package_file=/opt/tools/package-list-minimal.txt --verbose"
else
    android-accept-licenses.sh "sdkmanager --package_file=/opt/tools/package-list.txt --verbose"
fi

echo "Updating SDK"
update_sdk

echo "Accepting Licenses"
android-accept-licenses.sh "sdkmanager --licenses --verbose"
