"use strict";

var controllers = require('./lib/controllers');
var plugin = {};

plugin.init = function(params, callback) {
	var router = params.router,
		hostMiddleware = params.middleware,
		hostControllers = params.controllers;
		
	// We create two routes for every view. One API call, and the actual route itself.
	// Just add the buildHeader middleware to your route and NodeBB will take care of everything for you.

	router.get('/admin/plugins/filter-post-content', hostMiddleware.admin.buildHeader, controllers.renderAdminPage);
	router.get('/api/admin/plugins/filter-post-content', controllers.renderAdminPage);

	callback();
};

plugin.addAdminNavigation = function(header, callback) {
	header.plugins.push({
		route: '/plugins/filter-post-content',
		icon: 'fa-tint',
		name: 'Filter post content'
	});

	callback(null, header);
};

plugin.parsePost = function(data, callback) {
	console.log("Inside thing");
	console.log(data);

	callback(null, data);
};

module.exports = plugin;