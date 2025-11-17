#!/bin/bash
set -e

MELOS_VERSION="7.3.0"
FVM_VERSION="4.0.0"
POD_VERSION="1.16.2"

function isInstalled() {
    command -v "$1" >/dev/null 2>&1
}

function version {
    echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }';
}


isInstalled "fvm" || {
    echo "fvm is not installed."
    exit 1
}

if [ $(version $(fvm --version)) -lt $(version "$FVM_VERSION") ]; then
    echo "fvm is installed but needs to be updated to version '$FVM_VERSION' or higher."
    exit 1
fi

fvm use

isInstalled "melos" || {
    echo "melos is not installed, installing..."
    fvm flutter pub global activate melos $MELOS_VERSION
}

if [ $(version $(melos --version)) -ne $(version "$MELOS_VERSION") ]; then
    echo "melos is installed but needs to be installed at version '$MELOS_VERSION', updating..."
    fvm flutter pub global activate melos $MELOS_VERSION
fi

isInstalled "coverde" || {
    echo "coverde is not installed, installing..."
    fvm flutter pub global activate coverde
}

isInstalled "pod" || {
    echo "CocoaPods is not installed."
    exit 1
}

if [ $(version $(pod --version)) -ne $(version "$POD_VERSION") ]; then
    echo "CocoaPods is installed but needs to be installed at version '$POD_VERSION', please update."
    exit 1
fi

isInstalled "git" || {
    echo "git is not installed."
    exit 1
}

if [[ "$1" == "--all" ]]; then
    git clean -xdf
    fvm use
else
    fvm use
    fvm exec melos clean
fi

echo "bootstrapping monorepo..."
fvm exec melos bootstrap

echo "update CocoaPods..."
pod repo update
