module slog

import log

// Implements interface vlibs [`log.Logger`](https://modules.vlang.io/log.html#Logger).
pub struct TargetedVLogger {
	target string [required]
}

// Returns logger implements [`log.Logger`](https://modules.vlang.io/log.html#Logger).
// 
// ```v
// vlogger := slog.get_v_logger('net.websocket')
// websocket.new_client(url, logger: &vlogger)
// ```
pub fn get_v_logger(target string) TargetedVLogger {
	return TargetedVLogger{
		target: target
	}
}

pub fn (lg &TargetedVLogger) fatal(s string) {
	__logger.log(.error, lg.target, s)
}

pub fn (lg &TargetedVLogger) error(s string) {
	__logger.log(.error, lg.target, s)
}

pub fn (lg &TargetedVLogger) warn(s string) {
	__logger.log(.warn, lg.target, s)
}

pub fn (lg &TargetedVLogger) info(s string) {
	__logger.log(.info, lg.target, s)
}

pub fn (lg &TargetedVLogger) debug(s string) {
	__logger.log(.debug, lg.target, s)
}

pub fn (lg &TargetedVLogger) set_level(level log.Level) {
	// lv := match level {
	// 	.fatal { Level.error }
	// 	.error { Level.error }
	// 	.warn { Level.warn }
	// 	.info { Level.info }
	// 	.debug { Level.debug }
	// 	.disabled { Level.disabled}
	// }
	// mut log_mut := get_logger()
	// log_mut.set_level_for_target(lg.target, lv) // FIXME: "signal 11: segmentation fault" here
}
