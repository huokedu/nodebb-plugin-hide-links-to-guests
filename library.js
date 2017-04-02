"use strict";

var plugin = {};

plugin.alterContent = function(data, callback) {
	console.log("-------------------------------------------------------------------------------------------------------------------------------------------");
	console.log(data);

	callback(null, data);
};

module.exports = plugin;