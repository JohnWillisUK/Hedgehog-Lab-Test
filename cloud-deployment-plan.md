Cloud Deployment Plan – Hedgehog Lab DevOps Task

This guide explains how to deploy the full application (frontend, backend, and database) to Microsoft Azure using Terraform and GitHub Actions.

1. What’s Being Deployed

Frontend: React app (Static Web App)

Backend: FastAPI app in a Docker container (App Service)

Database: PostgreSQL Flexible Server

Infra as Code: Terraform in the infra/ folder

2. Step-by-Step Frontend Deployment (React)

🧭 Goal: Deploy the React app to Azure Static Web Apps

Steps:

Go to the Azure Portal → Create a new Static Web App

Use the following values:

Source: GitHub

Repo: JohnWillisUK/Hedgehog-Lab-Test

Branch: main

App location: frontend

Output location: build

API location: (leave blank)

Azure will create a GitHub Actions file in .github/workflows/

On every push to main, the React app is built and deployed to Azure

3. Step-by-Step Backend Deployment (FastAPI)

🧭 Goal: Build and run the backend as a Docker container on Azure App Service

Steps:

On push to main, GitHub Actions builds the backend Docker image

The image is pushed to GitHub Container Registry (GHCR):

ghcr.io/johnwillisuk/hedgehog-lab-test-backend:latest

Terraform provisions an Azure Linux App Service

The App Service pulls and runs the container using this image

4. Step-by-Step Database Deployment (PostgreSQL)

🧭 Goal: Deploy a managed Postgres database to Azure

Steps:

Terraform provisions azurerm_postgresql_flexible_server

The admin username and password come from terraform.tfvars

A firewall rule is added to allow access from the backend App Service

5. Deploying Infrastructure with Terraform

To deploy everything:

cd infra
az login
terraform init
terraform apply

To destroy everything:

terraform destroy

Files are in the infra/ directory:

main.tf, variables.tf, terraform.tfvars, outputs.tf

6. Security Notes

Environment variables (like DB password) are set in App Service

The DB is open to all IPs for now — this should be restricted in production

Frontend and backend are both publicly accessible

7. Suggested Improvements

Use Azure Key Vault to store secrets

Add monitoring (App Insights, logs)

Restrict DB access to App Service only (via VNet or IP)

Add staging environments

Tag backend images with Git SHA for version tracking

8. Summary

This setup separates concerns cleanly:

Frontend deploys automatically via GitHub → Azure Static Web Apps

Backend builds and pushes to GHCR, deployed via Terraform to App Service

Database is provisioned via Terraform

✅ Fast to deploy, easy to extend, and ready for real-world use.