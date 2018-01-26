<div align="center">
    <img src="./Sequel/Ressources/Assets.xcassets/AppIcon_Preview.imageset/AppIcon_Preview@3x.png" width="100px" height="auto">
    <h1>Sequel</h1>
    <a href="https://travis-ci.org/elbracht/sequel"><img src="https://travis-ci.org/elbracht/sequel.svg?branch=master"></a>
    <a href="https://github.com/elbracht/sequel/releases/tag/v0.1.0"><img src="https://img.shields.io/badge/release-v0.1.0-blue.svg"></a>
    <a href="https://github.com/elbracht/sequel/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
</div>

## Getting started

To access the TMDb API you need to create a shell script `./env-vars.sh` and insert the following environment variable with the API Key (v3 auth) from https://www.themoviedb.org/settings/api.

```bash
export TMDB_API_KEY=123456
```

We use Fabric to track user behaviour and crashes. To activate this function you need to insert the API Key and Build Secret from https://www.fabric.io/ in `./env-vars.sh`.

```bash
export FABRIC_API_KEY=123456
export FABRIC_BUILD_SECRET=123456
```

## License

Sequel is available under the MIT license. See the [LICENSE](https://github.com/elbracht/sequel/blob/master/LICENSE) file for more details.

---

<p align="center">Made with :heart: by <a href="https://github.com/elbracht">Alexander Elbracht</a></p>
