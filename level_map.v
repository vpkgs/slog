module slog

import os

pub struct ModLevelMapString {
pub mut:
	lv_map map[string]Level
}

// See `ModLevelMapString#set_level_from_str`
pub fn (mut lg ModLevelMapString) set_level_from_default_env() {
	val := os.getenv(default_env)
	lg.set_level_from_str(val)
}

// See `ModLevelMapString#set_level_from_str`
pub fn (mut lg ModLevelMapString) set_level_from_envvar(name string) {
	val := os.getenv(name)
	$if slog_envcheck ? {
		if val.len == 0 {
			panic("[WARN] envvar $name, is not set!!")
		}
	}
	lg.set_level_from_str(val)
}

// ```v
// lg.set_level_from_str('info,net.websocket=debug,mylib=info')
// // is equivalent to
// set_max_level(.info)
// lg.lv_map['net.websocket'] = .debug
// lg.lv_map['mylib'] = .info
// ```
[inline]
pub fn (mut lg ModLevelMapString) set_level_from_str(val string) {
	if val.len > 0 {
		for setting in val.split(',').map(it.trim_space()) {
			if idx := setting.index('=') {
				lg.lv_map[setting[..idx]] = level___from_str(setting[idx + 1..])
			} else {
				set_max_level(level___from_str(setting))
			}
		}
	}
}

[inline]
pub fn (lg &ModLevelMapString) enabled(target string, lv Level) bool {
	level := lg.lv_map[target] or { max_level }
	return int(lv) <= int(level)
}
