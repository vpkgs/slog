module slog

import term

const (
	empty_str = ''
)

pub const (
	__logger  = Logger(voidptr(0))
	max_level = Level.disabled
)

pub enum Level {
	disabled
	error
	warn
	info
	debug
	trace
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
pub fn get_logger() Logger {
	return __logger
}

[inline]
pub fn set_logger(log &Logger) {
	mut log_mut := unsafe { &__logger }
	unsafe {
		*log_mut = log
	}
}

pub fn log_enabled(target string, lv Level) bool {
	return true
}

pub fn log(lv Level, target string, msg string) {
	if int(lv) <= int(max_level) {
		// if logger_ := get_logger() {
		logger_ := get_logger()
		if log_enabled(target, lv) {
			logger_.log(lv, target, msg)
		}
		// } else {
		// 	$if dbg_logger ? {
		// 		eprintln('${@FILE}:${@LINE}:${@COLUMN} ${@METHOD}: logger not set')
		// 	}
		// }
	}
}

pub interface Logger {
	log(lv Level, target string, msg string)
}

pub struct BaseLogger {}

pub fn (lg &BaseLogger) fmt_level(lv Level) string {
	return match lv {
		.disabled { empty_str }
		.error { term.red('ERROR') }
		.warn { term.yellow('WARN ') }
		.info { term.green('INFO ') }
		.debug { term.cyan('DEBUG') }
		.trace { term.magenta('TRACE') }
	}
}

pub fn (lg &BaseLogger) fmt_level_for_file(lv Level) string {
	return match lv {
		.disabled { empty_str }
		.error { 'ERROR' }
		.warn { 'WARN' }
		.info { 'INFO' }
		.debug { 'DEBUG' }
		.trace { 'TRACE' }
	}
}
