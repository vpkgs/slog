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
		logger.set_level_from_envvar("NON_EXISTING_ENVVAR")
	}
	dump(max_level)
	log(.error, @MOD, 'test')
	log(.info, @MOD, 'it works!!')
	log(.debug, @MOD, 'Should not be there')
	log(.info, @MOD, 'it works2!!')

	vlogger := get_v_logger('net.websocket')
	vlogger.warn('Oops!')
	vlogger.info('info!')
	vlogger.fatal('fatal!')

	logger := get_targeted_logger('net.websocket')
	logger.warn('Oops!')
	logger.info('info! NOT IN OUTPUT (> .warn)')
	logger.trace('trace! NOT IN OUTPUT (> .warn)')
}
