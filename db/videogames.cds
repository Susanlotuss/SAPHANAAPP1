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
    name    : PlatformName;  // Ejemplo: PlayStation 5, Xbox Series X
    games   : Association to many Games on games.platform = $self;  // Relación con Juegos
};

entity Genres : cuid {
    name    : String(50);  // Ejemplo: Acción, Aventura, Estrategia
    games   : Composition of many Games on games.genre = $self;  // Relación con Juegos
};

entity Developers : cuid {
    name       : StudioName;
    foundedAt  : Date;
    location   : String(100);
    games      : Composition of many Games on games.developer = $self; // Relación con los juegos
};

entity Games : cuid {
    title       : GameTitle;
    releaseDate : Date;
    genre       : Association to Genres;   // Relación con Género
    platform    : Association to Platforms;  // Relación con Plataformas
    developer   : Association to Developers;
};
