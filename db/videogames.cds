// namespace app.videogames;

using {
    cuid,
    managed
} from '@sap/cds/common';

context app.videogames {
    type GameTitle    : String(150);
    type StudioName   : String(100);
    type PlatformName : String(50);

    entity Platforms : cuid {
        name  : PlatformName;
        games : Association to many Games
                    on games.platform = $self;
    };

    entity Genres : cuid {
        name  : String(50);
        games : Composition of many Games
                    on games.genre = $self;
    };

    entity Developers : cuid {
        name      : StudioName;
        foundedAt : Date;
        location  : String(100);
        games     : Composition of many Games
                        on games.developer = $self;
    };

    entity Games : cuid {
        title       : GameTitle;
        releaseDate : Date;
        genre       : Association to Genres;
        platform    : Association to Platforms;
        developer   : Association to Developers;
    };
}

@cds.persistence.exists 
@cds.persistence.calcview 
Entity V_VIDEOGAME {
key     TITLE: String(150)  @title: 'TITLE: TITLE' ; 
        RELEASEDATE: Date  @title: 'RELEASEDATE: RELEASEDATE' ; 
        NAME_DEVELOPERS: String(100)  @title: 'NAME_DEVELOPERS: NAME' ; 
        FOUNDEDAT: Date  @title: 'FOUNDEDAT: FOUNDEDAT' ; 
        LOCATION: String(100)  @title: 'LOCATION: LOCATION' ; 
        NAME_APP_VIDEOGAMES_GENRES: String(50)  @title: 'NAME_APP_VIDEOGAMES_GENRES: NAME_APP_VIDEOGAMES_GENRES' ; 
        NAME_APP_VIDEOGAMES_PLATFORMS: String(50)  @title: 'NAME_APP_VIDEOGAMES_PLATFORMS: NAME_APP_VIDEOGAMES_PLATFORMS' ; 
}
