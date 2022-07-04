# A Simple Logging library for V

- [Usage](#usage)
- [Motivation](#motivation)
- [Contribution](#contribution)
  - [Feature Request](#feature-request)
  - [Bugfix](#bugfix)

## Usage

### Simple
```v
import slog
import os

fn main() {
	ofilename := os.real_path(os.join_path(os.dir(@FILE), 'logfile'))
	slog.init_with_default_logger(ofilename, level: .info)

	slog.err('Warning here')
	slog.warn('Warning here')
	slog.info('Warning here')
	slog.debug('Warning here') // no output as `level` is `.info`
	slog.trace('Warning here') // no output as `level` is `.info`
}
```

If you need module info in log output

```v
import slog
import os

// Really want to generate following template by macro as `@MOD` value changes, or ...
fn err(msg string) {
	slog.log(.error, @MOD, msg)
}
fn warn(msg string) {
	slog.log(.warn, @MOD, msg)
}
fn info(msg string) {
	slog.log(.info, @MOD, msg)
}
fn debug(msg string) {
	slog.log(.debug, @MOD, msg)
}
fn trace(msg string) {
	slog.log(.trace, @MOD, msg)
}

fn main() {
	ofilename := os.real_path(os.join_path(os.dir(@FILE), 'logfile'))
	slog.init_with_default_logger(ofilename, level: .info)

	err('Warning here')
	warn('Warning here')
	info('Warning here')
	debug('Warning here') // no output as `level` is `.info`
	trace('Warning here') // no output as `level` is `.info`
}
```

or 

```v
// in your module
import slog

fn err(tag string, msg string) {
	slog.log(.error, tag, msg)
}
fn warn(tag string, msg string) {
	slog.log(.warn, tag, msg)
}
fn info(tag string, msg string) {
	slog.log(.info, tag, msg)
}
fn debug(tag string, msg string) {
	slog.log(.debug, tag, msg)
}
fn trace(tag string, msg string) {
	slog.log(.trace, tag, msg)
}

// then use
fname := os.real_path(os.join_path(os.dir(@FILE), 'logfile'))
slog.init_with_default_logger(fname, level: .trace) // should be called only once
//
error(@FILE, 'error')
warn(@FILE, 'warn')
info(@FILE, 'info')
debug(@FILE, 'debug')
trace(@FILE, 'trace')
```

### Custom Logger

See [`DefaultLogger` implementation](/default_logger.v).

## Motivation
V's `log` have to be mutable when log things.
It's quite difficult to use I thought.

I like `tracing` in Rust, so I used that as main reference.

## Contribution
### Feature Request
If you want new features:
- You can create a PR as a discussion (I may merge, but may not.).
- You can create an ISSUE before submit a PR, to make sure the PR will be merged (cannot promise 100%).

### Bugfix
Plz create Pull Requests
