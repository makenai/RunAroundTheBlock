$(document).ready(function() {

     console.log("gamepieces",gamePieces);


    function setupGamePieces() {
        // loop through the start moving all of the pieces
        for (var i = 0, gpLen = gamePieces.length; i < gpLen; i += 1) {
            var gp = gamePieces[i],
                marker = $('#gp' + gp.id);

            // find the start and end of the animation
            var spacePos = findPosOfSpace( gp.starting_space );
            marker.css( spacePos );
        }

    }

    function findPosOfSpace( space ) {
        var spaceDiv = $( '#space' + space ),
            spacePos = spaceDiv.position();
        return { 
            top: spacePos.top  + 5, 
            left: spacePos.left + 5
        };
    }

    function showCard( bonus, callback ) {
        var description = '<p>' + bonus.description + '</p>';
        if ( bonus.spaces > 0 ) { 
            description += '<p>Go forward ' + bonus.spaces + ' space.</p>';
        } else {
            description += '<p>Go back ' + Math.abs( bonus.spaces ) + ' space.</p>';
        }
        $('#card-modal div.card').html( description );
        $('#card-modal').fadeIn( function() {
         setTimeout( function() {
            $('#card-modal').fadeOut( callback );
         }, 1500 );   
        });
    }

    function showWheel( bonus, gp, callback ) {
        var players = [];
        $.each( gp.players, function( i, player ) {
            players.push( player.name );
        });
        spinWithStop( players, bonus.player_name );
    }

    function animateGamePieces() {
        for (var i = 0, gpLen = gamePieces.length; i < gpLen; i += 1) {
            var gp = gamePieces[i];
            animateGamePiece( gp, function( gp ) {
                $.each( gp.bonuses, function( i, bonus ) {
                    if ( bonus.type == 'wheel_of_fate' ) {
                        showWheel( bonus, gp, function() {
                            var newSpace = bonus.spaces + gp.currentSpace;
                            moveMarkerTo( gp, newSpace );
                        });
                    }
                    if ( bonus.type == 'card' ) {
                        showCard( bonus, function() {
                            var newSpace = bonus.spaces + gp.currentSpace;
                            moveMarkerTo( gp, newSpace );                            
                        });
                    }
                });
            });
        }
    }

    function moveMarkerTo( gp, space, callback ) {
        var marker = $('#gp' + gp.id);
        var endPos = findPosOfSpace( space );
        marker.animate( endPos, 500, callback ); 
    }

    function animateGamePiece( gp, callback ) {
        var endSpace = gp.starting_space + gp.spaces;
        if ( endSpace > 26 ) {
            endSpace = 26;
        }
        moveMarkerTo( gp, endSpace, function() {
            gp.currentSpace = endSpace;
            if ( callback ) 
                callback(gp);
        });
    }

    setupGamePieces();
    animateGamePieces();
});