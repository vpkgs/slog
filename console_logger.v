module slog

import os
import time

pub struct ConsoleLogger {
	BaseLogger
	ModLevelMapString
}

pub fn init_with_console_logger(opt DefaultLoggerOpt) &ConsoleLogger {
	mut log := &ConsoleLogger{}
	set_logger(log)
	set_max_level(opt.level)
	return log
}

pub fn (lg &ConsoleLogger) log(lv Level, target string, msg string) {
	if lg.enabled(target, lv) { // TODO: move inside `slog.log()` (segfault...)
		lg.log_console(lv, target, msg)
	}
}

fn (lg &ConsoleLogger) log_console(lv Level, target string, msg string) {
	timestamp := time.now().format_ss_micro()
	level := lg.fmt_level_for_term(lv)
	println('$timestamp $level $target: $msg')
}
