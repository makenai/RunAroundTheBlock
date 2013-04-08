$(document).ready(function() {

    var EVENT_QUEUE = [];

    function nextEvent( queue ) {
        var currentEvent = EVENT_QUEUE[ queue ].pop();
        if ( currentEvent )
            currentEvent();            
    }

    function queueEvent( queue, buttmonkey ) {
        if ( EVENT_QUEUE[ queue ] == null ) 
            EVENT_QUEUE[ queue ] = [];
        if ( buttmonkey )
            EVENT_QUEUE[ queue ].unshift( buttmonkey );
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
        $('#card-modal').toggleClass('no-ribbon', bonus.spaces < 1 );
        $('#card-modal div.card').html( description );
        $('#card-modal').fadeIn( function() {
         setTimeout( function() {
            $('#card-modal').fadeOut( callback );
         }, 1500 );   
        });
    }

    function showWheelCard( gp, bonus, callback ) {
        var team_average = 0;
        var description = '<h3 class="playerName">' + bonus.player_name + '</h3>';
        // faking it as I can't see any data I could use as team average
        description += '<div class="compWrap"><div class="compBox"><p>' + bonus.player_name + 
            '</p><p class="mileage">' + bonus.mileage + '</p><p>miles</p></div>';
        if ( bonus.spaces > 0 ) { 
            description += '<div class="compBox"><p class="croc">&gt;</p></div>';
        } else {
            description += '<div class="compBox"><p class="croc badcroc">&lt;=</p></div>';
        }
        description += '<div class="compBox"><p>Team Average</p><p class="mileage">' + gp.spaces + '</p><p>miles</p></div></div>';
        if ( bonus.spaces > 0 ) { 
            description += '<p class="desc">Since ' + bonus.player_name + ' exceeded your teams average, your team progresses a BONUS space!</p>';
        } else {
            description += '<p class="desc">You suck! No BONUS spaces for you!</p>';
        }
        $('#hero-modal').toggleClass('no-ribbon', bonus.spaces < 1 );
        $('#hero-modal p').html( description );
        $('#hero-modal').fadeIn( function() {
         setTimeout( function() {
            $('#hero-modal').fadeOut( callback );
         }, 2500 );   
        });
    }

    function showWheel( bonus, gp, callback ) {
        var players = [];
        $.each( gp.players, function( i, player ) {
            players.push( player.name );
        });
        spinWithStop( players, bonus.player_name, function() {
            showWheelCard( gp, bonus, callback );
        });
    }

    function animateGamePieces() {
        for (var i = 0, gpLen = gamePieces.length; i < gpLen; i += 1) {
            (function(i) {
                queueEvent( 2, function() {
                    (function (gp) {
                        gp.is_current_user = true
                        animateGamePiece( gp, function( gp ) {

                            $.each( gp.bonuses, function( i, bonus ) {

                                if ( bonus.type == 'wheel_of_fate' ) {
                                    queueEvent( 1, function() {
                                        if ( gp.is_current_user ) {
                                            showWheel( bonus, gp, function() {
                                                var newSpace = bonus.spaces + gp.current_space;
                                                moveMarkerTo( gp, newSpace, function() { nextEvent(1) } );
                                            });
                                        } else {
                                            var newSpace = bonus.spaces + gp.current_space;
                                            moveMarkerTo( gp, newSpace, function() { nextEvent(1) } );                                                
                                        }
                                    });
                                }
                                if ( bonus.type == 'card' ) {
                                    queueEvent( 1, function() {
                                        if ( gp.is_current_user ) {
                                            showCard( bonus, function() {
                                                var newSpace = bonus.spaces + gp.current_space;
                                                moveMarkerTo( gp, newSpace, function() { nextEvent(1) } );                            
                                            });
                                        } else {
                                            var newSpace = bonus.spaces + gp.current_space;
                                            moveMarkerTo( gp, newSpace, function() { nextEvent(1) } );                            
                                        }
                                    });
                                }
                            });
                            queueEvent( 1, function() { nextEvent(2); });
                            nextEvent( 1 );
                        });
                    })(gamePieces[i]);
                });
            })(i);
        }
        nextEvent( 2 );
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