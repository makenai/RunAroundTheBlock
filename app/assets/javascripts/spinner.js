var SPINNER_NUM_SLIDES = 50, SPINNER_RATE = 50;

function spinWithStop(players, winner, callback) {
	var sc = $(".spinner-container");
	assignRandom(0, sc, players);
	sc.fadeIn(1000, function() {
		moveSpinner(0, sc, players, winner, callback);
	});
}

function assignRandom(slide, sc, players) {
	var ss = sc.find(".spinner");

	for(var i=0; i<ss.length; i++) {
		$(ss[i]).text(players[(slide + i) % players.length]);
	}
}

function moveSpinner(curSlide, sc, players, winner, callback) {
	if(curSlide == SPINNER_NUM_SLIDES) {
		spinnerShowWinner(sc, winner, callback);
		return;
	}

	setTimeout(function() { 
		if(curSlide%2 == 0) {
			sc.find(".spinner").addClass("offset");
		} else {
			assignRandom(curSlide, sc, players);
			sc.find(".spinner").removeClass("offset");
		}
		curSlide++;
		moveSpinner(curSlide, sc, players, winner, callback);
	}, SPINNER_RATE);
}

function spinnerShowWinner(sc, winner, callback ) {
	sc.find(".mid").text(winner);
	setTimeout(function() { hideSpinner(sc, callback); }, 1000);
}

function hideSpinner(sc, callback) {
	sc.fadeOut(1000);
	if ( callback )
		callback();
}