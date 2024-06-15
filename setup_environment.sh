#!/bin/bash
set -e

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

if [ $(version $(fvm --version)) -lt $(version "3.0.0") ]; then
    echo "fvm is installed but needs to be updated to version 3.0.0 or higher."
    exit 1
fi

isInstalled "melos" || {
    echo "melos is not installed."
    exit 1
}

if [ $(version $(melos --version)) -lt $(version "6.0.0") ]; then
    echo "melos is installed but needs to be updated to version 6.0.0 or higher."
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
    melos clean
fi
melos bootstrap
