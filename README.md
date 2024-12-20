# SAPHANAAPP1
## _A Collection of small Apps_




HANAAPP1 is a collection of small applications built using SAP HANA Cloud and CAP (Cloud Application Programming) to create full-stack applications. The project showcases the integration of various functionalities such as a video game catalog, tournament management, and event & participant management, utilizing Fiori for frontend visualization and SAP's backend capabilities.



## Mini - Projects

### 1. Video Game Catalog


This application is developed following the tutorial "Combine CAP with SAP HANA Cloud to Create Full-Stack Applications" (https://developers.sap.com/mission.hana-cloud-cap.html). 
It allows users to view a catalog of video games, displaying details such as:
- Game Name
- Release Date
- Developer Information (including studio name, founding year, and location)

The frontend interface is powered by Fiori, offering a user-friendly experience for viewing the catalog.


### 2. Tournament Management

This project provides a CRUD (Create, Read, Update, Delete) system for managing tournaments and players participating in them. Users can create, modify, and delete tournaments and player entries.

```
TESTING:
You can test this CRUD functionality using the HTTP requests found in the "tests" folder, in the files:

- players.http
- tournaments.http
- actions.http
```

These files demonstrate the CRUD operations for tournaments and players in the system.

### 3. Events and Participants Management

This is a key project within the repository, designed to manage events and participants. It interacts with an external API called BUSINESS_PARTNER through SAP's system for external API integration, fulfilling the primary goal of this application.

```
TESTING:

You can test the API calls in the "tests" folder, specifically in:

- eventmanagement.http
```

This application allows CRUD operations on events and participants, with seamless integration of the BUSINESS_PARTNER external API.

## Features


- Full-stack applications with SAP HANA Cloud and CAP integration
- Fiori frontend for an intuitive user experience
- External API integration for event and participant management
- CRUD functionality for managing tournaments, players, and events

