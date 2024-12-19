using app.tournament from '../db/tournament_model';

service TournamentManagementService {

    // @odata.draft.enabled: true

    entity Tournaments as projection on tournament.Tournaments {
        ID,
        name,
        startDate,
        endDate,
        location,
        description,
        isActive,
        isCancelled,
        cancellationReason,
        participants : Association to many Players on participants.tournament = $self,
        teams        : Association to many Teams on teams.tournament = $self
    };

    entity Players as projection on tournament.Players {
        ID,
        name,
        email,
        gamerTag,
        tournament,
        team,
        businessPartnerID
    };

    entity Teams as projection on tournament.Teams {
        ID,
        name,
        players,
        tournament
    };

    // Tournament Actions
    action createTournament(name : String, startDate : Date, endDate : Date, location : String, description : String) returns String;
    action updateTournament(id : String, name : String, startDate : Date, endDate : Date, location : String, description : String) returns String;
    action deleteTournament(id : String) returns String;
    action cancelTournament(id : String, cancellationReason : String) returns String;
    action reopenTournament(id : String) returns String;

    // Player Actions
    action createPlayer(name : String, email : String, gamerTag : String, tournamentId : String, businessPartnerID : String) returns String;
    action updatePlayer(id : String, name : String, email : String, gamerTag : String, tournamentId : String, teamId : String) returns String;
    action deletePlayer(id : String) returns String;

    // Additional Operations
    action registerParticipant(tournamentId : String, playerId : String) returns String;
    action getEventParticipants(tournamentId : String) returns array of Players;

    action fetchParticipantDetails(businessPartnerID : String) returns String;
}
