# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.6] - 2022-06-29
### Added
- Allow empty action flag.

## [0.1.5] - 2020-04-21
### Added
- Allow empty host flag.

## [0.1.4] - 2019-10-15
### Added
- tvOS deployment target to Podspec.

### Changed
- Open callback URL through delegate.

### Removed
- `platforms` from `Package.swift`.

## [0.1.3] - 2019-10-15
### Added
- `url` property to `XCallbackURL` returning `URL` value.
- [Bazel](https://bazel.build) support.

## [0.1.2] - 2019-08-04
### Changed
- SuccessCallback takes optional Parameters value.
- Parameter names of `handleXCallbackURL` function in `XCallbackURLHandlerDelegate`.

### Fixed
- Use last path component for action.

## [0.1.1] - 2019-08-04
### Fixed
- Encode callback URLs with query allowed characters.

## [0.1.0] - 2019-08-04
### Added
- `XCallbackURL`
- `XCallbackURLHandler`

[0.1.5]: https://github.com/jasonnam/XCallbackURL/compare/0.1.4...0.1.5
[0.1.4]: https://github.com/jasonnam/XCallbackURL/compare/0.1.3...0.1.4
[0.1.3]: https://github.com/jasonnam/XCallbackURL/compare/0.1.2...0.1.3
[0.1.2]: https://github.com/jasonnam/XCallbackURL/compare/0.1.1...0.1.2
[0.1.1]: https://github.com/jasonnam/XCallbackURL/compare/0.1.0...0.1.1
[0.1.0]: https://github.com/jasonnam/XCallbackURL/releases/tag/0.1.0
