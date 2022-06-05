#!/bin/sh
if which mint >/dev/null; then
     mint run swiftlint --fix --format
else
    echo "Mint does not exist"
fi