module slog

import os

pub struct ModLevelMapString {
pub mut:
	lv_map map[string]Level
}

pub fn (mut lg ModLevelMapString) set_level_from_default_env() {
	val := os.getenv(default_env)
	lg.set_level_from_str(val)
}

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
