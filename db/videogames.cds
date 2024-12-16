namespace app.videogames;

using {
    cuid,
    managed
} from '@sap/cds/common';

// Tipos personalizados
type GameTitle : String(150);
type StudioName : String(100);
type PlatformName : String(50);

entity Platforms : cuid {
    name    : PlatformName;
    games   : Association to many Games on games.platform = $self;
};

entity Genres : cuid {
    name    : String(50);  // Ejemplo: Acción, Aventura, Estrategia
    games   : Composition of many Games on games.genre = $self;
};

entity Developers : cuid {
    name       : StudioName;
    foundedAt  : Date;
    location   : String(100);
    games      : Composition of many Games on games.developer = $self;
};

entity Games : cuid {
    title       : GameTitle;
    releaseDate : Date;
    genre       : Association to Genres;
    platform    : Association to Platforms;
    developer   : Association to Developers;
};
