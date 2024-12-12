sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'videogamecatalog/test/integration/FirstJourney',
		'videogamecatalog/test/integration/pages/GamesList',
		'videogamecatalog/test/integration/pages/GamesObjectPage'
    ],
    function(JourneyRunner, opaJourney, GamesList, GamesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('videogamecatalog') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheGamesList: GamesList,
					onTheGamesObjectPage: GamesObjectPage
                }
            },
            opaJourney.run
        );
    }
);