module slog

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
