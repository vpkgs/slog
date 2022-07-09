# Changelog

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
