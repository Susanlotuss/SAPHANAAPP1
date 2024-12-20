const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {

    // External BusinessPartner API
    this.on('fetchParticipantDetails', async ({ data: { businessPartnerID } }) => {
        try {
            const bupa = await cds.connect.to('API_BUSINESS_PARTNER');

            
            this.on('READ', 'Foo', req => {
                console.log(JSON.stringify(req.query));
                return bupa.run(req.query);
            });

            
            if (!businessPartnerID) {
                throw new Error('BusinessPartnerID no proporcionado.');
            }

            
            const response = await bupa.run(
                SELECT.from('A_BusinessPartner').where({ BusinessPartner: businessPartnerID })
            );

            if (!response || !response[0]) {
                throw new Error('No se encontraron detalles del socio.');
            }

            return response;
        } catch (error) {
            console.error(`Error al consultar los detalles del socio: ${error.message}`);
            throw new Error('Error al consultar los detalles del socio.');
        }
    });


    // Create event
    this.on('createEvent', async (req) => {
        const { name, startDate, endDate, location, description } = req.data;
        await cds.run(INSERT.into('app.eventsandparticipants.Events').entries({
            name,
            startDate,
            endDate,
            location,
            description,
            isActive: true,
            isCancelled: false
        }));
        return `Evento '${name}' creado exitosamente.`;
    });

    // Reopen event
    this.on('reopenEvent', async (req) => {
        const { id } = req.data;
        const event = await cds.run(SELECT.from('app.eventsandparticipants.Events').where({ ID: id }));

        if (!event) {
            throw new Error('Evento no encontrado.');
        }

        await cds.run(UPDATE('app.eventsandparticipants.Events')
            .set({ isCancelled: false, cancellationReason: null, isActive: true })
            .where({ ID: id }));
        return `Event with ID ${id} reopen succesfully.`;
    });

    // Cancel event
    this.on('cancelEvent', async (req) => {
        const { id, cancellationReason } = req.data;
        const event = await cds.run(SELECT.from('app.eventsandparticipants.Events').where({ ID: id }));

        if (!event) {
            throw new Error('Evento no encontrado.');
        }

        await cds.run(UPDATE('app.eventsandparticipants.Events')
            .set({ isCancelled: true, cancellationReason, isActive: false })
            .where({ ID: id }));
        return `Event with ID ${id} canceled: ${cancellationReason}.`;
    });

    // Register a participant to an event
    this.on('registerParticipant', async (req) => {
        const { eventId, participantId } = req.data;
        console.log(`Recibiendo eventId: ${eventId}, participantId: ${participantId}`);

        const participant = await cds.run(SELECT.from('app.eventsandparticipants.participants').where({ ID: participantId }));
        const event = await cds.run(SELECT.from('app.eventsandparticipants.events').where({ ID: eventId }));

        console.log('Jugador:', participant);
        console.log('Torneo:', event);

        if (participant && event) {
            await cds.run(UPDATE('app.eventsandparticipants.participants')
                .set({ event0_ID: eventId })
                .where({ ID: participantId }));
            return `Jugador con ID ${participantId} registrado en el torneo con ID ${eventId}.`;
        } else {
            throw new Error('Jugador o Torneo no encontrado.');
        }
    });

    // Create participant
    this.on('createParticipant', async (req) => {
        const { name, email, phone, eventId, businessPartnerID } = req.data;
        console.log(businessPartnerID);

        let partnerDetails;
        try {
            
            if (!businessPartnerID) {
                throw new Error('BusinessPartnerID es obligatorio.');
            }
            partnerDetails = await this.fetchParticipantDetails({ businessPartnerID });

            console.log(partnerDetails);

            if (!partnerDetails || !partnerDetails[0]) {
                throw new Error('El BusinessPartnerID no es válido o no se encontró.');
            }
        } catch (error) {
            console.error(`Error al validar el BusinessPartnerID: ${error.message}`);
            throw new Error('Error al validar el BusinessPartnerID.');
        }

        
        await cds.run(INSERT.into('app.eventsandparticipants.Participants').entries({
            name,
            email,
            phone,
            event0: eventId ? { ID: eventId } : null,
            businessPartnerID,
        }));

        return `Participante '${name}' creado exitosamente.`;
    });


    // Update participant
    this.on('updateParticipant', async (req) => {
        const { id, name, email, phone, eventId, businessPartnerID } = req.data;

        const participant = await cds.run(SELECT.from('app.eventsandparticipants.Participants').where({ ID: id }));

        if (!participant) {
            throw new Error('Participante no encontrado.');
        }

        if (businessPartnerID) {
            throw new Error('El campo BusinessPartnerID no puede ser actualizado.');
        }

        await cds.run(UPDATE('app.eventsandparticipants.Participants')
            .set({
                name,
                email,
                phone,
                event0: eventId ? { ID: eventId } : null
            })
            .where({ ID: id }));

        return `Participante con ID ${id} actualizado exitosamente.`;
    });

    // Delete participant
    this.on('deleteParticipant', async (req) => {
        const { id } = req.data;

        const participant = await cds.run(SELECT.from('app.eventsandparticipants.Participants').where({ ID: id }));

        if (!participant) {
            throw new Error('Participante no encontrado.');
        }

        await cds.run(DELETE.from('app.eventsandparticipants.Participants').where({ ID: id }));

        return `Participante con ID ${id} eliminado exitosamente.`;
    });

    // Get event participants
    this.on('getEventParticipants', async (req) => {
        const { eventId } = req.data;
        const participants = await cds.run(
            SELECT.from('app.eventsandparticipants.Participants').where({ event0: eventId })
        );

        if (participants.length === 0) {
            return `No se encontraron participantes para el evento con ID ${eventId}.`;
        }

        return participants;
    });

    // Delete event
    this.on('deleteEvent', async (req) => {
        const { id } = req.data;

        const event = await cds.run(SELECT.from('app.eventsandparticipants.Events').where({ ID: id }));

        if (!event) {
            throw new Error('Event no encontrado.');
        }

        await cds.run(DELETE.from('app.eventsandparticipants.Events').where({ ID: id }));

        return `Event con ID ${id} eliminado exitosamente.`;
    });

    // Update Event
    this.on('updateEvent', async (req) => {
        const { id, name, startDate, endDate, location, description } = req.data;

        const event = await cds.run(SELECT.from('app.eventsandparticipants.Events').where({ ID: id }));

        if (!event) {
            throw new Error('Event not found.');
        }

        await cds.run(UPDATE('app.eventsandparticipants.Events')
            .set({
                name,
                startDate,
                endDate,
                location,
                description
            })
            .where({ ID: id }));

        return `Event with ID ${id} updated succesfully.`;
    });
})
