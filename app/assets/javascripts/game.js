$(document).ready(function() {

    var EVENT_QUEUE = [];

    function nextEvent() {
        var currentEvent = EVENT_QUEUE.pop();
        if ( currentEvent )
            currentEvent();
    }

    function queueEvent( buttmonkey ) {
        if ( buttmonkey )
            EVENT_QUEUE.push( buttmonkey );
    }

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

    function showWheelCard( bonus, callback ) {
        if ( callback )
            callback();
    }

    function showWheel( bonus, gp, callback ) {
        var players = [];
        $.each( gp.players, function( i, player ) {
            players.push( player.name );
        });
        spinWithStop( players, bonus.player_name, function() {
            showWheelCard( bonus, callback );
        });
    }

    function animateGamePieces() {
        for (var i = 0, gpLen = gamePieces.length; i < gpLen; i += 1) {
            var gp = gamePieces[i];
            animateGamePiece( gp, function( gp ) {
                $.each( gp.bonuses, function( i, bonus ) {

                    if ( bonus.type == 'wheel_of_fate' ) {
                        queueEvent( function() {
                            showWheel( bonus, gp, function() {
                                var newSpace = bonus.spaces + gp.current_space;
                                moveMarkerTo( gp, newSpace, nextEvent );
                            });
                        });
                    }
                    if ( bonus.type == 'card' ) {
                        queueEvent( function() {
                            showCard( bonus, function() {
                                var newSpace = bonus.spaces + gp.current_space;
                                moveMarkerTo( gp, newSpace, nextEvent );                            
                            });
                        });
                    }
                });
                nextEvent();
            });
        }
    }

    function moveMarkerTo( gp, space, callback ) {
        var marker = $('#gp' + gp.id);
        var step = function( i ) {
            var endPos = findPosOfSpace( i );
            var properties = { duration: 250 };
            if ( i == space )
                properties.complete = callback;
            marker.animate( endPos, properties );
            gp.current_space = space;
        }
        if ( space > gp.current_space ) {
            for ( var i = gp.current_space; i <= space; i++ )
                step( i );            
        } else {
            for ( var i = gp.current_space; i >= space; i-- )
                step( i );                        
        }
    }

    function animateGamePiece( gp, callback ) {
        var endSpace = gp.starting_space + gp.spaces;
        if ( endSpace > 26 ) {
            endSpace = 26;
        }
        moveMarkerTo( gp, endSpace, function() {
            if ( callback ) 
                callback(gp);
        });
    }

    setupGamePieces();
    animateGamePieces();
});