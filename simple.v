module slog

pub fn err(target string, msg string) {
	log(.error, target, msg)
}

pub fn warn(target string, msg string) {
	log(.warn, target, msg)
}

pub fn info(target string, msg string) {
	log(.info, target, msg)
}

pub fn debug(target string, msg string) {
	log(.debug, target, msg)
}

pub fn trace(target string, msg string) {
	log(.trace, target, msg)
}
