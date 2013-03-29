$(document).ready(function() {

     console.log("gamepieces",gamePieces);


    function setupGamePieces() {
        // loop through the start moving all of the pieces
        for (var i = 0, gpLen = gamePieces.length; i < gpLen; i += 1) {
            var gp = gamePieces[i],
                marker = $('#gp' + gp.id);

            // find the start and end of the animation
            var spacePosArr = findPosOfSpace(gp.starting_space, gp.spaces, marker);
            marker.css({'left': spacePosArr[0], 'top': spacePosArr[1]});

            console.log('sp',spacePosArr);

        }
        // run the animation (will this block? I hope it does)
        //animateGamePiece(marker);
    }

    function findPosOfSpace(start, spaces, marker) {
        var endSpace = parseInt(start, 10) + parseInt(spaces, 10),
            spaceDiv = $('#space' + endSpace),
            spacePos = spaceDiv.position(),
            spacePosArr = [];

            spacePosArr.push(Math.ceil(spacePos.left + (spacePos.left / 2)) - 38),
            spacePosArr.push(Math.ceil(spacePos.top + (spacePos.top / 2)));

        return spacePosArr;
    }

    function animateGamePiece(marker) {

    }

    //var init = function initGame() {
        setupGamePieces();
   // };
});