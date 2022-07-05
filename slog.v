module slog

import term

const (
	empty_str = ''
)

pub const (
	__logger    = &Logger(voidptr(0))
	max_level   = Level.disabled
	default_env = 'V_LOG'
)

pub enum Level {
	disabled
	error
	warn
	info
	debug
	trace
}
fn level___from_str(lv_str string) Level {
	match lv_str {
		'error' { return .error }
		'warn' { return .warn }
		'info' { return .info }
		'debug' { return .debug }
		'trace' { return .trace }
		else {
			$if !prod {
				dump('invalid level: $lv_str')
				panic('Invalid level result in `.disabled` in production (-prod)')
			}
			return .disabled
		}
	}
}

pub fn set_max_level(level Level) {
	unsafe {
		max_level = level
	}
	$if dbg_logger ? {
		dump(max_level)
	}
}

[inline]
pub fn get_logger() &Logger {
	$if !prod {
		if isnil(__logger) {
			panic('logger is nil in production (-prod)')
		}
	}
	return __logger
}

[inline]
pub fn set_logger(log &Logger) {
	mut log_mut := unsafe { &__logger }
	unsafe {
		*log_mut = log
	}
}

pub fn log(lv Level, target string, msg string) {
	if max_level == .disabled {
		return
	}

	logger_ := get_logger()
	// if logger_.enabled(target, lv) { // FIXME: This result in segfault... 
		logger_.log(lv, target, msg)
	// }
}

pub interface Logger {
	log(lv Level, target string, msg string)
	// enabled(target string, lv Level) bool
}

pub struct BaseLogger {}

pub fn (lg &BaseLogger) fmt_level_for_term(lv Level) string {
	return match lv {
		.disabled { empty_str }
		.error { term.red('ERROR') }
		.warn { term.yellow('WARN ') }
		.info { term.green('INFO ') }
		.debug { term.cyan('DEBUG') }
		.trace { term.magenta('TRACE') }
	}
}

pub fn (lg &BaseLogger) fmt_level(lv Level) string {
	return match lv {
		.disabled { empty_str }
		.error { 'ERROR' }
		.warn { 'WARN' }
		.info { 'INFO' }
		.debug { 'DEBUG' }
		.trace { 'TRACE' }
	}
}
