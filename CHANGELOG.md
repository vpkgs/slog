# Changelog

## v3.0.1
- add dummy method `set_level` to `TargetedVLogger` (followed V's change https://github.com/vlang/v/commit/a35356758cd4b2d5dea046eedd0a01ce92ab4c16)

## v3.0.0

- Full diff https://github.com/vpkgs/slog/compare/v2.0.0..v3.0.0

### 🎉 New features
- read logger level configuration from environment variables
- target level `max_level` configuration
- easy vlib `log.Logger` interop, using `slog.get_v_logger(target)`

### 🛠 Breaking changes
- `max_level` and `enabled?` check is, now, responsibility of logger implementation.
- public method name of `BaseLogger` changed

## v2.0.0

- Full diff https://github.com/vpkgs/slog/compare/v1.0.0..v2.0.0

### 🛠 Breaking changes
- simple fn (`err`, `warn` ...) now requires `target` as 1st arg
