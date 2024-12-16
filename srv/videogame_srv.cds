using app.videogames from '../db/videogames';
using { sap } from '@sap/cds-common-content';
using V_VIDEOGAME from '../db/videogames';

service VideogameCatalogService {
    @requires           : 'authenticated-user'
    @cds.redirection.target
    @odata.draft.enabled: true

    entity Games as projection on videogames.Games;
    @cds.redirection.target: 'VideogameCatalogService.Games'

    @requires: 'Admin'
    entity Developers as projection on videogames.Developers;

    @requires: 'Admin'
    entity Platforms as projection on videogames.Platforms;

    @readonly
    entity Languages as projection on sap.common.Languages;

    @readonly
    @restrict: [{ grant: 'READ', where: 'name = ''Aventura-Horror'''}]
    entity Genres as projection on videogames.Genres;

    @readonly
    entity V_Videogame as projection on V_VIDEOGAME;
}
