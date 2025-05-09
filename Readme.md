Hedgehog Lab DevOps Task

A full-stack containerized web application demonstrating DevOps best practices with CI/CD, Docker, and Terraform on Azure.

🧱 Architecture

Frontend: React (deployed to Azure Static Web Apps)

Backend: FastAPI (containerized, deployed to Azure App Service via GHCR)

Database: PostgreSQL (Azure Flexible Server)

Infrastructure: Provisioned with Terraform

🚀 Live URLs

Frontend: https://hedgehoglab-frontend.azurestaticapps.net

Backend health check: https://hedgehoglab-backend.azurewebsites.net/healthz

🧪 Local Development

Prerequisites

Docker & Docker Compose

Node.js & npm

Run locally:

docker compose up --build

Visit:

Frontend: http://localhost:3000

Backend: http://localhost:8000/healthz

🧩 Environment Variables

Frontend (frontend/.env):

REACT_APP_API_BASE_URL=http://localhost:8000

Backend:

Reads POSTGRES_PASSWORD from environment variables

🔁 CI/CD

Frontend:

Auto-deployed via GitHub Actions (Azure creates workflow file)

Builds and deploys on every push to main

Backend:

GitHub Actions builds Docker image and pushes to GHCR

Azure App Service pulls latest image from GHCR

🔧 Infrastructure Deployment

Terraform files live in the infra/ folder.

Deploy:

cd infra
az login
terraform init
terraform apply

Destroy:

terraform destroy

🔐 Security Notes

DB credentials passed via App Service environment variables

DB is currently public for demo purposes — should be IP-restricted or VNet-protected in production

📈 Improvements

Use Azure Key Vault for secrets

Lock down DB access

Add monitoring and logging

Auto-deploy Terraform via GitHub Actions

✅ Summary

This repo demonstrates:

End-to-end CI/CD for a 3-tier app

Clean IaC with Terraform

Real cloud deployment on Azure

Easy to run, test, and extend.

