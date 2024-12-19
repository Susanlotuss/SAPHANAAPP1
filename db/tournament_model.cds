// namespace app.tournament;

using { cuid } from '@sap/cds/common';

context app.tournament {
    type TournamentName   : String(150);
    type TournamentLocation : String(100);
    type PlayerName       : String(100);
    type TeamName         : String(100);
    type BusinessPartnerID : String(50);

    entity Tournaments : cuid {
        name             : TournamentName;
        startDate        : Date;
        endDate          : Date;
        location         : TournamentLocation;
        description      : String;
        isActive         : Boolean;
        isCancelled      : Boolean;
        cancellationReason : String;
        participants     : Association to many Players on participants.tournament = $self;
        teams            : Association to many Teams on teams.tournament = $self;
    };

    entity Players : cuid {
        name           : PlayerName;
        email          : String(100);
        gamerTag       : String(50);
        tournament     : Association to Tournaments;
        team           : Association to Teams;
        businessPartnerID : BusinessPartnerID;
    };

    entity Teams : cuid {
        name           : TeamName;
        players        : Composition of many Players on players.team = $self;
        tournament     : Association to Tournaments;
    };
}
