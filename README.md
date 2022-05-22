# contrail

[![CI](https://github.com/tokizuoh/contrail/actions/workflows/main.yml/badge.svg)](https://github.com/tokizuoh/contrail/actions/workflows/main.yml)

<p align="center">
  <img src="https://user-images.githubusercontent.com/37968814/168440294-2097be29-f452-4c50-a0fa-a1a53d8845a0.png" width="250">
</p>

## About
A simple app to view your cycling workouts in SwiftUI.

<p align="center">
  <img src="https://user-images.githubusercontent.com/37968814/169692359-ea969e14-1ca8-4d03-bbc3-5c57a72d4010.png" width="1000">
</p>

## Development Environment
  
```
$ xcodebuild -version
Xcode 13.3
Build version 13E113
```
  
## Before Development

### Git Hooks
Add the issue number to the beginning of the commit message.

```sh
$ make set-git-hooks-commit-msg
```

### Mint

```sh
# https://github.com/yonaskolb/Mint
$ git clone https://github.com/yonaskolb/Mint.git
$ cd Mint
$ swift run mint
```