# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Features

* **statistics:** add session_id tags ([dec833f](https://github.com/Chronophylos/DETH_Additions/commit/dec833f))
* **statistics:** add statistic for ace pointing ([a1197fa](https://github.com/Chronophylos/DETH_Additions/commit/a1197fa))
* **flags:** add vehicle killed event handler for flag and texture reset ([52d781c](https://github.com/Chronophylos/DETH_Additions/commit/52d781c))

### Bug Fixes

* **statistics:** restore client ACE collection; broadcast session_id; bind fired params
* **statistics:** restore Antistasi per-player sampling on clients
* **statistics:** skip empty scores without aborting the rest of the roster
* **statistics:** fired event never sending data ([c93d800](https://github.com/Chronophylos/DETH_Additions/commit/c93d800))
* **spawner:** attack and spawn near the selected player (`BIS_fnc_spawnEnemy` arg order)
* **flags:** publicize texture reset; killed cleanup uses flag/texture state
* **utils:** add missing stringtable entry ([3c532cc](https://github.com/Chronophylos/DETH_Additions/commit/3c532cc))
* **flags:** fix applyTexture undefined var and vehicleColor setting callback
* **spawner:** run Spawn Enemy on server only; stop using local `player`
* **uncon_chat:** use channel id + 5 for `enableChannel`

### Refactors

* **statistics:** make postInit easier to read ([6c0b37e](https://github.com/Chronophylos/DETH_Additions/commit/6c0b37e))

### Build

* include CHANGELOG.md in mod release ([8ce3c45](https://github.com/Chronophylos/DETH_Additions/commit/8ce3c45))
* bump `actions/checkout` to v4

### Documentation

* fix README badge typo; document Statistics and Uncon Chat
* add Modules wiki page; repair Home wiki links

## [1.4.0](https://github.com/Chronophylos/DETH_Additions/compare/v1.3.4...v1.4.0) (2025-02-24)

### Features

* **flags:** change texture to color ([5b0ad6a](https://github.com/Chronophylos/DETH_Additions/commit/5b0ad6a659a52f3bb2f8dcb2d61010456ed3d5ec))

### Bug Fixes

* **flags:** remove _this ([ed43de7](https://github.com/Chronophylos/DETH_Additions/commit/ed43de7661decc919b49da2a68921f7b95db3f82))
* **flags:** settings not sticking ([b33d6e1](https://github.com/Chronophylos/DETH_Additions/commit/b33d6e1cf1d6f4f49e41ee805d9b904225bd82ef))
* **statistics:** crash on mission start on server ([a8acf57](https://github.com/Chronophylos/DETH_Additions/commit/a8acf572c981af6d749d80921fd614c1bab6d83f)), closes [#5](https://github.com/Chronophylos/DETH_Additions/issues/5)
* **uncon_chat:** script error when going unconscious ([219c55f](https://github.com/Chronophylos/DETH_Additions/commit/219c55f176f972abcbb5718e536a611a9032be89))

## [1.3.4](https://github.com/Chronophylos/DETH_Additions/compare/v1.3.2...v1.3.4) (2025-02-21)

## [1.3.2](https://github.com/Chronophylos/DETH_Additions/compare/v1.3.1...v1.3.2) (2025-02-19)

## [1.3.1](https://github.com/Chronophylos/DETH_Additions/compare/v1.3.0...v1.3.1) (2025-02-18)

# [1.3.0](https://github.com/Chronophylos/DETH_Additions/compare/v1.2.0...v1.3.0) (2025-02-18)

# [1.2.0](https://github.com/Chronophylos/DETH_Additions/compare/v1.1.1...v1.2.0) (2025-02-15)

## [1.1.1](https://github.com/Chronophylos/DETH_Additions/compare/v1.1.0...v1.1.1) (2024-10-18)

# [1.1.0](https://github.com/Chronophylos/DETH_Additions/compare/v1.0.0...v1.1.0) (2024-10-14)

# 1.0.0 (2024-09-17)
