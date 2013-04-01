$(document).ready(function() {
	doTestSpin();
});

var SPINNER_NUM_SLIDES = 50, SPINNER_RATE = 50;

function doTestSpin() {
	spinWithStop(["Pawel", "Susan", "Amelia", "Shaun", "Darshan"], "Pawel");
}

function spinWithStop(players, winner) {
	var sc = $(".spinner-container");
	assignRandom(0, sc, players);
	sc.fadeIn(1000, function() {
		moveSpinner(0, sc, players, winner);
	});
}

function assignRandom(slide, sc, players) {
	var ss = sc.find(".spinner");

	for(var i=0; i<ss.length; i++) {
		$(ss[i]).text(players[(slide + i) % players.length]);
	}
}

function moveSpinner(curSlide, sc, players, winner) {
	if(curSlide == SPINNER_NUM_SLIDES) {
		spinnerShowWinner(sc, winner);
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
		moveSpinner(curSlide, sc, players, winner);
	}, SPINNER_RATE);
}

function spinnerShowWinner(sc, winner) {
	sc.find(".mid").text(winner);
	setTimeout(function() { hideSpinner(sc); }, 5000);
}

function hideSpinner(sc) {
	sc.fadeOut(1000);
}