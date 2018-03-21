(function() {
	"use strict";

	angular
		.module("spa-demo.bars")
		.directive("sdBars", BarsDirective);

	BarsDirective.$inject = ["spa-demo.APP_CONFIG"];

	function BarsDirective(APP_CONFIG) {
		var directive = {
			templateUrl: APP_CONFIG.bars_html,
			replace: true,
			bindToController: true,
			controller: "spa-demo.bars.BarsController",
			controllerAs: "barsVM",
			restrict: "E",
			scope: {
			},
			link: link
		};

		return directive;

		function link(scope, element, attrs) {
			console.log("CitiesDirective", scope);
		}
	}

})();