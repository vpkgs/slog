module slog

import os

fn test_dev() {
	dump(max_level)
	orig_max := max_level
	set_max_level(.trace)
	dump(max_level)
	assert orig_max != max_level

	os.setenv(default_env, 'trace,net.websocket=warn', false)
	{
		mut logger := init_with_default_logger('myfile')
		logger.set_level_from_default_env()
	}
	dump(max_level)
	log(.error, @MOD, 'test')
	log(.info, @MOD, 'it works!!')
	log(.debug, @MOD, 'Should not be there')
	log(.info, @MOD, 'it works2!!')
}
