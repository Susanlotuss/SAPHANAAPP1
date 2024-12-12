using VideogameCatalogService as service from '../../srv/videogame_srv';

annotate service.Games with @(
    UI.HeaderInfo: {
        Title       : { $Type: 'UI.DataField', Value: title },
        TypeName    : 'Game',
        TypeNamePlural: 'Games',
        Description : { $Type: 'UI.DataField', Value: genre }
    },
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { $Type: 'UI.DataField', Label: 'Title', Value: title },
            { $Type: 'UI.DataField', Label: 'Developer', Value: developer.name },
            { $Type: 'UI.DataField', Label: 'Developer Location', Value: developer.location }
        ]
    },
    UI.Facets : [
        {
            $Type: 'UI.ReferenceFacet',
            ID: 'GeneratedFacet1',
            Label: 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup'
        }
    ],
    UI.LineItem : [
        { $Type: 'UI.DataField', Label: 'Title', Value: title },
        { $Type: 'UI.DataField', Label: 'Release Date', Value: releaseDate },
        { $Type: 'UI.DataField', Label: 'Genre', Value: genre },
        { $Type: 'UI.DataField', Label: 'Platform', Value: platform }
    ]
);

annotate service.Games with {
    developer @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Developers',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : developer_ID,        
                ValueListProperty : 'ID',                
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',            
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'foundedAt',        
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'location',         
            }
        ],
    }
};

annotate service.Developers with @(
    UI.HeaderInfo: {
        Title       : { $Type: 'UI.DataField', Value: name },
        TypeName    : 'Developer',
        TypeNamePlural: 'Developers',
        Description : { $Type: 'UI.DataField', Value: location }
    },
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { $Type: 'UI.DataField', Label: 'Studio Name', Value: name },
            { $Type: 'UI.DataField', Label: 'Founded At', Value: foundedAt },
            { $Type: 'UI.DataField', Label: 'Location', Value: location }
        ]
    },
    UI.Facets : [
        {
            $Type: 'UI.ReferenceFacet',
            ID: 'GeneratedFacet1',
            Label: 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup'
        }
    ],
    UI.LineItem : [
        { $Type: 'UI.DataField', Label: 'Studio Name', Value: name },
        { $Type: 'UI.DataField', Label: 'Founded At', Value: foundedAt },
        { $Type: 'UI.DataField', Label: 'Location', Value: location }
    ]
);
