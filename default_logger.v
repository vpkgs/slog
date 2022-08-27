module slog

import os
import time

pub struct DefaultLogger {
	BaseLogger
	ModLevelMapString
	ofname_prefix string
mut:
	ofname string
	ofile  os.File
}

[params]
pub struct DefaultLoggerOpt {
pub:
	level Level = Level.info
}

pub fn init_with_default_logger(ofname string, opt DefaultLoggerOpt) &DefaultLogger {
	name := '$ofname-0.log'
	ofile := os.open_append(name) or { panic('couldn\'t opening log file $name for appending') }
	mut log := &DefaultLogger{
		ofname_prefix: ofname
		ofname: name
		ofile: ofile
	}
	set_logger(log)
	set_max_level(opt.level)
	return log
}

pub fn (lg &DefaultLogger) log(lv Level, target string, msg string) {
	if lg.enabled(target, lv) { // TODO: move inside `slog.log()` (segfault...)
		lg.log_file(lv, target, msg)
		lg.log_console(lv, target, msg)
	}
}

fn (lg &DefaultLogger) log_file(lv Level, target string, msg string) {
	mut l := unsafe { lg }

	timestamp := time.now().format_ss_micro()
	level := l.fmt_level(lv)
	l.ofile.writeln('$timestamp [$level] $target: $msg') or {
		eprintln('failed to write following msg to file: $timestamp [$level] $target: $msg')
		panic(err)
	}
	l.ofile.flush()
}

fn (lg &DefaultLogger) log_console(lv Level, target string, msg string) {
	timestamp := time.now().format_ss_micro()
	level := lg.fmt_level_for_term(lv)
	println('$timestamp $level $target: $msg')
}
