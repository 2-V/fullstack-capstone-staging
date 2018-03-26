(function() {
	"use strict";

	angular
		.module("spa-demo.bars")
		.factory("spa-demo.bars.Bar", BarFactory);

	BarFactory.$inject = ["$resource", "spa-demo.APP_CONFIG"];
	function BarFactory($resource, APP_CONFIG) {
		return $resource(APP_CONFIG.server_url + "/api/bars/:id",
			{ id: '@id' },
			{ 
				update: { method: "PUT", transformRequest: buildNestedBody },
				save: { method: "POST", transformRequest: buildNestedBody }
			}
			);
	}

	function buildNestedBody(data) {
		return angular.toJson( { bar: data } )
	}
})();