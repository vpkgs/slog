# Changelog

## v3.0.0

https://github.com/vpkgs/slog/compare/v2.0.0..v3.0.0#diff-b335630551682c19a781afebcf4d07bf978fb1f8ac04c6bf87428ed5106870f5

### 🎉 New features
- read logger level configuration from environment variables
- target level `max_level` configuration
- easy vlib `log.Logger` interop, using `slog.get_v_logger(target)`

### 🛠 Breaking changes
- `max_level` and `enabled?` check is, now, responsibility of logger implementation.


## v2.0.0

https://github.com/vpkgs/slog/compare/v1.0.0..v2.0.0#diff-b335630551682c19a781afebcf4d07bf978fb1f8ac04c6bf87428ed5106870f5

### 🛠 Breaking changes
- simple fn (`err`, `warn` ...) now requires `target` as 1st arg
