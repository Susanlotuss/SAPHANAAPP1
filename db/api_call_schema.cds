using {API_BUSINESS_PARTNER as bupa} from '../srv/external/API_BUSINESS_PARTNER';

using { cuid } from '@sap/cds/common';

context app.eventsandparticipants {
    type EventName           : String(150);
    type EventLocation       : String(100);
    type ParticipantName     : String(100);
    type BusinessPartnerID   : String(50);

    entity Events : cuid {
        name                 : EventName;
        startDate            : Date;
        endDate              : Date;
        location             : EventLocation;
        description          : String;
        isActive             : Boolean;
        isCancelled          : Boolean;
        cancellationReason   : String;
        participants         : Association to many Participants on participants.event0 = $self;
    };

    entity Participants : cuid {
        name                 : ParticipantName;
        email                : String(100);
        phone                : String(20);
        event0                : Association to Events;
        businessPartnerID    : BusinessPartnerID;
    };

    entity Suppliers as
    projection on bupa.A_BusinessPartner {
        key BusinessPartner          as ID,
            BusinessPartnerFullName  as fullName,
            BusinessPartnerIsBlocked as isBlocked
    }
}
