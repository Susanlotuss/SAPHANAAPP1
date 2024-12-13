using VideogameCatalogService as service from '../../srv/videogame_srv';

annotate service.Games with @(
    // Primera Vista (Resumen)
    UI.HeaderInfo: {
        Title: { $Type: 'UI.DataField', Value: title },
        TypeName: 'Game',
        TypeNamePlural: 'Games',
        Description: { $Type: 'UI.DataField', Value: releaseDate }
    },

    UI.LineItem: [
        // Solo mostrar el título y la fecha de lanzamiento en la primera vista
        { $Type: 'UI.DataField', Label: 'Title', Value: title },
        { $Type: 'UI.DataField', Label: 'Release Date', Value: releaseDate }
    ],

    // Segunda Vista (Detalles)
    UI.FieldGroup #GeneralInfoGroup : {
        $Type: 'UI.FieldGroupType',
        Data: [
            { $Type: 'UI.DataField', Label: 'Title', Value: title },
            // { $Type: 'UI.DataField', Label: 'Release Date', Value: releaseDate },
            { $Type: 'UI.DataField', Label: 'Genre', Value: genre.name },
            { $Type: 'UI.DataField', Label: 'Platform', Value: platform.name }
        ]
    },
    UI.FieldGroup #DeveloperInfoGroup : {
        $Type: 'UI.FieldGroupType',
        Data: [
            { $Type: 'UI.DataField', Label: 'Developer', Value: developer.name },
            { $Type: 'UI.DataField', Label: 'Developer Location', Value: developer.location },
            { $Type: 'UI.DataField', Label: 'Founded At', Value: developer.foundedAt }
        ]
    },

    // Facetas para la navegación entre secciones
    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            ID: 'GeneralInfoFacet',
            Label: 'General Information',
            Target: '@UI.FieldGroup#GeneralInfoGroup'
        },
        {
            $Type: 'UI.ReferenceFacet',
            ID: 'DeveloperInfoFacet',
            Label: 'Developer Information',
            Target: '@UI.FieldGroup#DeveloperInfoGroup'
        }
    ]
);

// Anotación para la entidad Developers
annotate service.Developers with @(
    UI.HeaderInfo: {
        Title: { $Type: 'UI.DataField', Value: name },
        TypeName: 'Developer',
        TypeNamePlural: 'Developers',
        Description: { $Type: 'UI.DataField', Value: location }
    },

    // Grupo con los detalles del desarrollador
    UI.FieldGroup #DeveloperDetailsGroup : {
        $Type: 'UI.FieldGroupType',
        Data: [
            { $Type: 'UI.DataField', Label: 'Studio Name', Value: name },
            { $Type: 'UI.DataField', Label: 'Founded At', Value: foundedAt },
            { $Type: 'UI.DataField', Label: 'Location', Value: location }
        ]
    },

    // Facet para los detalles del desarrollador
    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            ID: 'DeveloperDetailsFacet',
            Label: 'Developer Details',
            Target: '@UI.FieldGroup#DeveloperDetailsGroup'
        }
    ],

    // LineItem con información básica del desarrollador
    UI.LineItem: [
        { $Type: 'UI.DataField', Label: 'Studio Name', Value: name },
        { $Type: 'UI.DataField', Label: 'Founded At', Value: foundedAt },
        { $Type: 'UI.DataField', Label: 'Location', Value: location }
    ]
);

// Anotación para la entidad Platforms
annotate service.Platforms with @(
    UI.HeaderInfo: {
        Title: { $Type: 'UI.DataField', Value: name },
        TypeName: 'Platform',
        TypeNamePlural: 'Platforms',
        Description: { $Type: 'UI.DataField', Value: name }
    },

    // LineItem para mostrar el nombre de la plataforma
    UI.LineItem: [
        { $Type: 'UI.DataField', Label: 'Platform Name', Value: name }
    ]
);

// Anotación para la entidad Genres
annotate service.Genres with @(
    UI.HeaderInfo: {
        Title: { $Type: 'UI.DataField', Value: name },
        TypeName: 'Genre',
        TypeNamePlural: 'Genres',
        Description: { $Type: 'UI.DataField', Value: name }
    },

    // LineItem para mostrar el nombre del género
    UI.LineItem: [
        { $Type: 'UI.DataField', Label: 'Genre Name', Value: name }
    ]
);
