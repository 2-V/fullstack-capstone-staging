(function() {
	"use strict";

	angular
		.module("spa-demo.bars")
		.controller("spa-demo.bars.BarsController", BarsController);

		BarsController.$inject = ["spa-demo.bars.Bar"];

		function BarsController(Bar) {
			var vm = this;
			vm.bars;
			vm.bar;
			vm.edit = edit;
			vm.create = create;
			vm.update = update;
			vm.remove = remove;

			activate();
			return;

			function activate(){
				newBar();
				vm.bars = Bar.query();
			}

			function newBar(){
				vm.bar = new Bar();
			}

			function handleError(response) {
				console.log(response);
			}

			function edit(object) {
				vm.bar = object;
			}

			function create(){
				vm.bar.$save()
					.then(function(response){
						console.log(response);
						vm.bars.push(vm.bar);
						newBar();
					})
					.catch(handleError);
			}

			function update(){
				vm.bar.$update()
					.then(function(response){
						console.log(response);
					})
					.catch(handleError);
			}

			function remove() {
				vm.bar.$delete()
					.then(function(response){
						// will maintain bar with server
						vm.bars = Bar.query(); 
						//remove the element from local array
						// removeElement(vm.bars, vm.bar);
						newBar();
					})
					.catch(handleError);
			}

			function removeElement(elements, element) {
				for (var i=0; i<elements.length; i++) {
					if(elements[i].id == element.id) {
						elements.splice(i,1);
						break;
					}
				}
			}
		}
})();