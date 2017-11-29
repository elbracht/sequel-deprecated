<div align="center">
    <img src="./Sequel/Ressources/Assets.xcassets/AppIcon_Preview.imageset/AppIcon_Preview@3x.png" width="100px" height="auto">
    <h1>Sequel</h1>
    <a href="https://travis-ci.org/elbracht/sequel"><img src="https://travis-ci.org/elbracht/sequel.svg?branch=master"></a>
    <a href="https://github.com/elbracht/sequel/releases/tag/v0.1.0"><img src="https://img.shields.io/badge/release-v0.1.0-blue.svg"></a>
    <a href="https://github.com/elbracht/sequel/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
</div>

## Getting started

To access the TMDb API you need to create the following config extension and insert the API Key (v3 auth) from https://www.themoviedb.org/settings/api.

`Sequel/Supporting Files/Config+API.swift`

```swift
extension Config {
    struct TMDb {
        static let apiKey = ""
    }
}
```
