module tracing

import time
import term
import os

const (
	empty_str = ''
)
pub const (
	__logger = Logger(voidptr(0))
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
	unsafe { max_level = level }
	$if dbg_logger ? {
		dump(max_level)
	}
}
[inline]
pub fn get_logger() Logger {
	return __logger
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

pub struct DefaultLoggger {
	BaseLogger
	ofname_prefix string
mut:
	ofname string
	ofile         os.File
}

[params]
pub struct DefaultLogggerOpt {
pub:
	level Level = Level.info
}
pub fn init_with_default_logger(ofname string, opt DefaultLogggerOpt) {
	name := '$ofname-0.log'
	ofile := os.open_append(name) or {
		panic('couldn\'t opening log file $name for appending')
	}
	mut log := &DefaultLoggger {
		ofname_prefix: ofname,
		ofname: name,
		ofile: ofile,
	}
	mut log_mut := unsafe{ &__logger }
	unsafe {
		*log_mut = log
	}
	set_max_level(opt.level)
}

pub fn (lg &DefaultLoggger) log(lv Level, target string, msg string) {
	lg.log_file(lv, target, msg)
	lg.log_console(lv, target, msg)
}

fn (lg DefaultLoggger) log_file(lv Level, target string, msg string) {
	mut l := unsafe { lg }

	timestamp := time.now().format_ss_micro()
	level := l.fmt_level_for_file(lv)
	l.ofile.writeln('$timestamp [$level] $target: $msg') or { 
		eprintln('failed to write following msg to file: $timestamp [$level] $target: $msg')
		panic(err)
	}
	l.ofile.flush()
}

fn (lg &DefaultLoggger) log_console(lv Level, target string, msg string) {
	timestamp := time.now().format_ss_micro()
	level := lg.fmt_level(lv)
	println('$timestamp $level $target: $msg')
}

pub fn err(msg string) {
	log(.error, empty_str, msg)
}
pub fn warn(msg string) {
	log(.warn, empty_str, msg)
}
pub fn info(msg string) {
	log(.info, empty_str, msg)
}
pub fn debug(msg string) {
	log(.debug, empty_str, msg)
}
pub fn trace(msg string) {
	log(.trace, empty_str, msg)
}
