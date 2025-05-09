Hedgehog Lab DevOps Task

This repository demonstrates a full-stack containerized web application using DevOps best practices with CI/CD, Docker, Terraform, and Azure. The solution includes a three-tier architecture, where the frontend communicates with the backend, and updates are persisted in a PostgreSQL database.

🧱 Architecture
The application is structured into three primary components:

Frontend (React): Deployed to Azure Static Web Apps

Backend (FastAPI): Containerized and deployed to Azure App Service via GitHub Container Registry (GHCR)

Database (PostgreSQL): Managed by Azure Flexible Server

Infrastructure: Provisioned using Terraform for a consistent, repeatable setup

✅ Requirements Checklist
1. Frontend - React Application (ID: REQ-FRONTEND)
✅ Frontend is a React application.

✅ The application is deployed to Azure Static Web Apps.

✅ API communication with the backend is handled via environment variables.

2. Backend - FastAPI (ID: REQ-BACKEND)
✅ The backend is implemented with FastAPI.

✅ The backend is containerized and deployed to Azure App Service.

✅ The Docker image for the backend is pushed to GitHub Container Registry (GHCR) and pulled by Azure App Service.

✅ The backend communicates with the PostgreSQL database for data persistence.

3. Database - PostgreSQL (ID: REQ-DB)
✅ A PostgreSQL database is used.

✅ The database is managed by Azure Flexible Server.

✅ Data persistence is ensured using Docker volumes in development and managed databases in production.

4. Infrastructure as Code - Terraform (ID: REQ-IAC)
✅ The infrastructure is provisioned using Terraform.

✅ Terraform files are located in the infra/ folder.

✅ Provisioning and destruction of resources are handled with terraform apply and terraform destroy.

5. CI/CD (ID: REQ-CICD)
✅ Frontend: Automatically deployed via GitHub Actions on every push to the main branch.

✅ Backend: The backend Docker image is built and pushed to GHCR using GitHub Actions. Azure App Service pulls the latest image from GHCR.

✅ CI/CD workflows are automated, reducing manual intervention.

🧪 Local Development

Prerequisites
Before running locally, ensure you have the following installed:

Docker & Docker Compose

Node.js & npm

Run Locally
See provided instructions in Root folder

Once the containers are up, visit the following URLs:

Frontend: http://localhost:3000

Backend Health Check: http://localhost:8000/healthz
