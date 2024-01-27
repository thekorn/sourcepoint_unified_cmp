#!/bin/bash

set -e

#!/bin/bash

if [[ "$1" != "patch" && "$1" != "minor" && "$1" != "major" ]]; then
  echo "Error: Argument must be 'patch', 'minor', or 'major'"
  exit 1  # Exit with a status of 1 to indicate an error
fi


echo "copy docs to sourcepoint_unified_cmp..."

cp README.md packages/sourcepoint_unified_cmp/README.md
cp -r docs packages/sourcepoint_unified_cmp/

git add .

melos version \
    -V sourcepoint_unified_cmp:$1 \
    -V sourcepoint_unified_cmp_android:$1 \
    -V sourcepoint_unified_cmp_ios:$1 \
    -V sourcepoint_unified_cmp_platform_interface:$1 \
    -r

melos publish --no-dry-run