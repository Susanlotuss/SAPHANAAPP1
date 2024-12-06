using app.videogames from '../db/videogames';
using { sap } from '@sap/cds-common-content';

service VideogameCatalogService {

    @odata.draft.enabled: true
    entity Games as projection on videogames.Games;

    entity Developers as projection on videogames.Developers;

    @readonly
    entity Languages as projection on sap.common.Languages;
}
