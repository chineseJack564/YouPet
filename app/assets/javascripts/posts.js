// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener('turbolinks:load', function() {
	main_post();
	initAutocomplete();
	onPlaceChanged()
});


function main_post() {
	$('.accept-order').each(function() {
		var $order = $(this);
		$(this).on('click', function() {
			console.log($(this));
		});
	});

	if(document.getElementById("posttype")){
		document.getElementById("posttype").onchange = function() {
		document.getElementById("price").disabled = (this.value == "Adopcion");
	}
	}
}

function initAutocomplete() {
	auto = new google.maps.places.Autocomplete(
		document.getElementById('auto_loc'),{
			componentRestrictions: {'country': ['CL']},
			fields: ['place_id', 'geometry', 'name']
		}
	);
	auto.addListener('place_changed', onPlaceChanged);
}

function onPlaceChanged(){
	var place = auto.getPlace();
	if(!place.geometry) {
		document.getElementById('auto_loc').placeholder='Enter a place';
	}
	else{
		console.log(place.geometry.location.lat());
		document.getElementById('lat').value = place.geometry.location.lat();
		document.getElementById('long').value = place.geometry.location.lng();
	}
}