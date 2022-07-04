module slog

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
