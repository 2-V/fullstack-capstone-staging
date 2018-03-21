(function() {
	"use strict";

	angular
		.module("spa-demo.foos")
		.controller("spa-demo.foos.FoosController", FoosController);

		FoosController.$inject = ["spa-demo.foos.Foo"];

		function FoosController(Foo) {
			var vm = this;
			vm.foos;
			vm.foo;
			vm.edit = edit;
			vm.create = create;
			vm.update = update;
			vm.remove = remove;

			activate();
			return;

			function activate(){
				newFoo();
				vm.foos = Foo.query();
			}

			function newFoo(){
				vm.foo = new Foo();
			}

			function handleError(response) {
				console.log(response);
			}

			function edit(object) {
				vm.foo = object;
			}

			function create(){
				vm.foo.$save()
					.then(function(response){
						console.log(response);
						vm.foos.push(vm.foo);
						newFoo();
					})
					.catch(handleError);
			}

			function update(){
				vm.foo.$update()
					.then(function(response){
						console.log(response);
					})
					.catch(handleError);
			}

			function remove() {
				vm.foo.$delete()
					.then(function(response){
						// will maintain state with server
						vm.foos = Foo.query(); 
						//remove the element from local array
						// removeElement(vm.foos, vm.foo);
						newFoo();
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