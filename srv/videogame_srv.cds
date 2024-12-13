using app.videogames from '../db/videogames';
using { sap } from '@sap/cds-common-content';

service VideogameCatalogService {

    @odata.draft.enabled: true

    // Proyección de las entidades desde el modelo 'videogames'
    entity Games as projection on videogames.Games;
    @cds.redirection.target: 'VideogameCatalogService.Games'

    entity Developers as projection on videogames.Developers;
    entity Platforms as projection on videogames.Platforms;

    @readonly
    entity Languages as projection on sap.common.Languages;

    entity Genres as projection on videogames.Genres;
}
