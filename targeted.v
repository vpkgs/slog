module slog

// Easy usage
pub struct TargetedLogger {
	target string [required]
}

// ```v
// logger := get_targeted_logger('my.important_process')
// logger.info('started')
// logger.error('received invalid value: $value')
// ```
pub fn get_targeted_logger(target string) TargetedLogger {
	return TargetedLogger{
		target: target
	}
}

pub fn (lg &TargetedLogger) error(s string) {
	__logger.log(.error, lg.target, s)
}

pub fn (lg &TargetedLogger) warn(s string) {
	__logger.log(.warn, lg.target, s)
}

pub fn (lg &TargetedLogger) info(s string) {
	__logger.log(.info, lg.target, s)
}

pub fn (lg &TargetedLogger) debug(s string) {
	__logger.log(.debug, lg.target, s)
}

pub fn (lg &TargetedLogger) trace(s string) {
	__logger.log(.trace, lg.target, s)
}
