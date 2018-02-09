(function() {
	"use strict";

	angular
		.module("spa-demo.authn", [
			"ui.router",
			"ng-token-auth",
			"spa-demo.cities"
		]);
})();