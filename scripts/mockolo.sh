#!/bin/sh

if which mint >/dev/null; then
    rm -f $SRCROOT/contrail/MockResults.swift
    mint run mockolo mockolo --sourcedirs $SRCROOT/contrail --destination $SRCROOT/contrail/MockResults.swift --mock-final
else
    echo "Mint does not exist"
fi