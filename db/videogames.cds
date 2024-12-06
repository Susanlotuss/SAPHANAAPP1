namespace app.videogames;

using {
    cuid,
    managed
} from '@sap/cds/common';

type GameTitle : String(150);
type StudioName : String(100);
type Platform : String(50);

entity Developers : cuid, managed {
    name       : StudioName;
    foundedAt  : Date;
    location   : String(100);
    games      : Composition of many Games
                   on games.developer = $self; // Relación con los juegos
};

entity Games : cuid {
    title       : GameTitle;
    releaseDate : Date;
    genre       : String(50);
    platform    : Platform;
    developer   : Association to Developers;
};
