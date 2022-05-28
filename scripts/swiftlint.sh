#!/bin/sh
if which swiftlint >/dev/null; then
    swiftlint --fix --format
else
    echo "SwiftLint does not exist"
fi