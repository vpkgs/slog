A Logging library for Vlang, can use Easily.

- [Usage](#usage)
- [Motivation](#motivation)
- [Contribution](#contribution)
  - [Feature Request](#feature-request)
  - [Bugfix](#bugfix)

## Usage

```v
import tracing
import os

fn err(msg string) {
	tracing.log(.error, @MOD, msg)
}
fn warn(msg string) {
	tracing.log(.warn, @MOD, msg)
}
fn info(msg string) {
	tracing.log(.info, @MOD, msg)
}
fn debug(msg string) {
	tracing.log(.debug, @MOD, msg)
}
fn trace(msg string) {
	tracing.log(.trace, @MOD, msg)
}

fn main() {
	ofilename := os.real_path(os.join_path(os.dir(@FILE), 'logfile'))
	tracing.init_with_default_logger(ofilename, level: .info)

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
import tracing

fn err(tag string, msg string) {
	tracing.log(.error, tag, msg)
}
fn warn(tag string, msg string) {
	tracing.log(.warn, tag, msg)
}
fn info(tag string, msg string) {
	tracing.log(.info, tag, msg)
}
fn debug(tag string, msg string) {
	tracing.log(.debug, tag, msg)
}
fn trace(tag string, msg string) {
	tracing.log(.trace, tag, msg)
}

// then use
fname := os.real_path(os.join_path(os.dir(@FILE), 'logfile'))
tracing.init_with_default_logger(fname, level: .trace) // should be called only once
//
error(@FILE, 'error')
warn(@FILE, 'warn')
info(@FILE, 'info')
debug(@FILE, 'debug')
trace(@FILE, 'trace')
```

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
