module slog

fn test_dev() {
	dump(max_level)
	orig_max := max_level
	set_max_level(.trace)
	dump(max_level)
	assert orig_max != max_level

	init_with_default_logger('myfile')

	log(.error, @MOD, 'test')
	log(.info, @MOD, 'it works!!')
	log(.debug, @MOD, 'Should not be there')
	log(.info, @MOD, 'it works2!!')
}