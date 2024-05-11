#!/bin/bash
set -e

if [[ "$1" == "--all" ]]; then
    git clean -xdf
else
    melos clean
fi
fvm use
melos bootstrap
