const cds = require('@sap/cds');
const axios = require('axios');

module.exports = cds.service.impl(function () {

    // Create tournament
    this.on('createTournament', async (req) => {
        const { name, startDate, endDate, location, description } = req.data;
        await cds.run(INSERT.into('app.tournament.Tournaments').entries({
            name,
            startDate,
            endDate,
            location,
            description,
            isActive: true,
            isCancelled: false
        }));
        return `Torneo '${name}' creado exitosamente.`;
    });

    this.on('registerParticipant', async (req) => {
        const { tournamentId, playerId } = req.data;
        console.log(`Recibiendo tournamentId: ${tournamentId}, playerId: ${playerId}`);

        const player = await cds.run(SELECT.from('app.tournament.Players').where({ ID: playerId }));
        const tournament = await cds.run(SELECT.from('app.tournament.Tournaments').where({ ID: tournamentId }));

        console.log('Jugador:', player);
        console.log('Torneo:', tournament);

        if (player && tournament) {
            await cds.run(UPDATE('app.tournament.Players')
                .set({ tournament_ID: tournamentId })
                .where({ ID: playerId }));
            return `Jugador con ID ${playerId} registrado en el torneo con ID ${tournamentId}.`;
        } else {
            throw new Error('Jugador o Torneo no encontrado.');
        }
    });

    // Cancel tournament
    this.on('cancelTournament', async (req) => {
        const { id, cancellationReason } = req.data;
        const tournament = await cds.run(SELECT.from('app.tournament.Tournaments').where({ ID: id }));
        if (!tournament) {
            throw new Error('Torneo no encontrado.');
        }
        await cds.run(UPDATE('app.tournament.Tournaments')
            .set({ isCancelled: true, cancellationReason, isActive: false })
            .where({ ID: id }));
        return `Torneo con ID ${id} cancelado: ${cancellationReason}.`;
    });

    // Reopen tournament
    this.on('reopenTournament', async (req) => {
        const { id } = req.data;
        const tournament = await cds.run(SELECT.from('app.tournament.Tournaments').where({ ID: id }));
        if (!tournament) {
            throw new Error('Torneo no encontrado.');
        }
        await cds.run(UPDATE('app.tournament.Tournaments')
            .set({ isCancelled: false, cancellationReason: null, isActive: true })
            .where({ ID: id }));
        return `Torneo con ID ${id} reabierto exitosamente.`;
    });

    // Create Player
    this.on('createPlayer', async (req) => {
        const { name, email, gamerTag, tournamentId, teamId, businessPartnerID } = req.data;

        let partnerDetails;
        try {
            partnerDetails = await this.fetchParticipantDetails({ businessPartnerID });
            if (!partnerDetails || !partnerDetails.BusinessPartner) {
                throw new Error('El BusinessPartnerID no es válido o no se encontró.');
            }
        } catch (error) {
            console.error(`Error al validar el BusinessPartnerID: ${error.message}`);
            throw new Error('Error al validar el BusinessPartnerID.');
        }

        let team = null;
        if (teamId) {
            team = await cds.run(SELECT.one.from('app.tournament.Teams').where({ ID: teamId }));
            if (!team) {
                throw new Error(`El equipo con ID ${teamId} no existe.`);
            }
        }

        await cds.run(INSERT.into('app.tournament.Players').entries({
            name,
            email,
            gamerTag,
            tournament: tournamentId ? { ID: tournamentId } : null,
            team: team ? { ID: teamId } : null,
            businessPartnerID,
        }));

        return `Jugador '${name}' creado exitosamente.`;
    });

    // Player details (External API)
    this.on('fetchParticipantDetails', async ({ data: { businessPartnerID } }) => {
        try {
            const url = `https://my408665-api.s4hana.cloud.sap/sap/opu/odata/sap/API_BUSINESS_PARTNER/A_BusinessPartner('${businessPartnerID}')`;
            const response = await axios.get(url, {
                auth: {
                    username: 'CAP_BOOTCAMP_S4_API_USER',
                    password: 'WS$UGgbhkG8EEvUpccCgmedHhmHRiWeZVGfvcUPE'
                },
                headers: {
                    'Accept': 'application/json'
                }
            });

            if (response.data && response.data.d) {
                return response.data.d;
            } else {
                throw new Error('No se encontraron detalles del socio.');
            }
        } catch (error) {
            console.error(`Error al consultar la API externa: ${error.message}`);
            throw new Error('Error al consultar la API externa.');
        }
    });

    // Update Player
    this.on('updatePlayer', async (req) => {
        const { id, name, email, gamerTag, tournamentId, teamId, businessPartnerID } = req.data;

        const player = await cds.run(SELECT.from('app.tournament.Players').where({ ID: id }));
        if (!player) {
            throw new Error('Jugador no encontrado.');
        }

        if (businessPartnerID) {
            throw new Error('El campo BusinessPartnerID no puede ser actualizado.');
        }

        let team = null;
        if (teamId) {
            team = await cds.run(SELECT.one.from('app.tournament.Teams').where({ ID: teamId }));
            if (!team) {
                throw new Error(`El equipo con ID ${teamId} no existe.`);
            }
        }

        await cds.run(UPDATE('app.tournament.Players')
            .set({
                name,
                email,
                gamerTag,
                tournament: tournamentId ? { ID: tournamentId } : null,
                team: team ? { ID: teamId } : null
            })
            .where({ ID: id })
        );

        return `Jugador con ID ${id} actualizado exitosamente.`;
    });

    // Delete Player
    this.on('deletePlayer', async (req) => {
        const { id } = req.data;

        const player = await cds.run(SELECT.from('app.tournament.Players').where({ ID: id }));
        if (!player) {
            throw new Error('Jugador no encontrado.');
        }

        await cds.run(DELETE.from('app.tournament.Players').where({ ID: id }));

        return `Jugador con ID ${id} eliminado exitosamente.`;
    });

    // Get Event players
    this.on('getEventParticipants', async (req) => {
        const { tournamentId } = req.data;
        console.log('Datos recibidos:', req);

        console.log('Consulta de jugadores para torneo:', tournamentId);
        const players = await cds.run(
            SELECT.from('app.tournament.Players').where({ tournament_ID: tournamentId })
        );
        console.log('Jugadores encontrados:', players);


        if (players.length === 0) {
            return `No se encontraron participantes para el torneo con ID ${tournamentId}.`;
        }

        return players;
    });
});