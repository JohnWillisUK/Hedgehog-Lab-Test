
# Deployment Guide – Hedgehog Lab DevOps Test

This guide explains how I deployed the application locally using Docker Compose.

The app is split into three main parts:
- A React frontend where users can enter a name
- A FastAPI backend which handles API requests
- A PostgreSQL database where the names are stored

Everything runs in containers, and I’ve configured Docker volumes so data isn’t lost if containers are stopped or restarted.

---

## Running the App Locally

1. Clone the repo:
-------- In a bash terminal--------
git clone https://github.com/JohnWillisUK/Hedgehog-Lab-Test.git
cd Hedgehog-Lab-Test
----------------.-------------------

2. Build and run the containers:

-------- In a bash terminal--------
docker-compose up --build
----------------.-------------------


3. Once this has been completed, visit the frontend in your browser:
http://localhost:3000

You can enter a name and submit it. The name will be saved to the database and appear in the results list.

4. The backend is accessible at:

http://localhost:8000

## Optional: View Data in the Postgres Container
You can also inspect the database manually to confirm data is persisting:

-------- In a bash terminal--------
docker exec -it hedgehog-lab-test-db-1 psql -U postgres
----------------.-------------------

Once inside psql

----------- Inside pSQL -----------
SELECT * FROM submissions;
----------------.-------------------


and to exit type..

----------- Inside pSQL -----------
\q
----------------.-------------------


## Stopping the App
To stop the app and remove everything:
(Warning: If you complete this step the data will not persist!)

-------- In a bash terminal--------
docker-compose down -v
----------------.-------------------



###############################################################################################

## Tech Stack and Structure

├── backend/     # FastAPI backend
├── frontend/    # React frontend
├── db/          # SQL script to create the table
├── docker-compose.yml
├── .env.example
The backend uses FastAPI and connects to the database using environment variables.

The frontend is a simple React app that talks to the backend via fetch requests.

The database is PostgreSQL and initialized using init.sql.

## Data Persistence
PostgreSQL uses a named Docker volume. This means if the container crashes or restarts, the data is still there.

You can see the volume in the docker-compose.yml file under volumes:.

This will shut down all services and remove volumes (including database data).

## Notes
CORS is enabled in the backend to allow communication with the frontend.

A health check is available at /healthz for use in CI/CD.

All services are on the same Docker network and talk to each other using service names.
