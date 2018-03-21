(function() {
	"use strict";

	angular
		.module("spa-demo")
		.config(RouterFunction);

		RouterFunction.$inject = ["$barProvider",
								  "$urlRouterProvider",
								  "spa-demo.APP_CONFIG"];

		function RouterFunction($barProvider, $urlRouterProvider, APP_CONFIG) {
			$barProvider
			.bar("home",{
				url: "/",
				templateUrl: APP_CONFIG.main_page_html,
				// controller: ,
				// controllerAs: ,
			})

			$urlRouterProvider.otherwise("/");
		}
})();