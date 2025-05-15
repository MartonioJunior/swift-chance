#!/bin/zsh

swift package resolve
swift build -v
swift test -v