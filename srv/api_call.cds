using app.eventsandparticipants from '../db/api_call_schema';

service EventManagementService {

    entity Foo    as projection on eventsandparticipants.Suppliers;

    entity Events as projection on eventsandparticipants.Events {
        ID,
        name,
        startDate,
        endDate,
        location,
        description,
        isActive,
        isCancelled,
        cancellationReason,
        participants : Association to many Participants on participants.event0 = $self
    };

    entity Participants as projection on eventsandparticipants.Participants {
        ID,
        name,
        email,
        phone,
        event0,
        businessPartnerID
    };

    // Event Actions
    action createEvent(name : String, startDate : Date, endDate : Date, location : String, description : String) returns String;
    action updateEvent(id : String, name : String, startDate : Date, endDate : Date, location : String, description : String) returns String;
    action deleteEvent(id : String) returns String;
    action cancelEvent(id : String, cancellationReason : String) returns String;
    action reopenEvent(id : String) returns String;

    // Participant Actions
    action createParticipant(name : String, email : String, phone : String, eventId : String, businessPartnerID : String) returns String;
    action updateParticipant(id : String, name : String, email : String, phone : String, eventId : String) returns String;
    action deleteParticipant(id : String) returns String;

    // Additional Operations
    action registerParticipant(eventId : String, participantId : String) returns String;
    action getEventParticipants(eventId : String) returns array of Participants;

    action fetchParticipantDetails(businessPartnerID : String) returns String;
}