# Cloud Deployment Plan for Hedgehog Lab DevOps Task

This document outlines how the multi-container application (React frontend, FastAPI backend, PostgreSQL database) is deployed to Microsoft Azure using Infrastructure as Code and GitHub-integrated CI/CD.

---

## 1. Overview

The application architecture consists of:

* **Frontend**: React app deployed via Azure Static Web Apps (with GitHub Actions)
* **Backend**: FastAPI app containerized and deployed to Azure App Service from GitHub Container Registry (GHCR)
* **Database**: Azure Database for PostgreSQL Flexible Server
* **Infrastructure**: Provisioned using Terraform stored in `infra/`

---

## 2. Frontend Deployment (React)

The frontend is managed through **Azure Static Web Apps**, created via the Azure Portal and linked to GitHub.

### Steps:

1. Delete any previously Terraform-created Static Web App (optional cleanup)
2. Create a new Static Web App from the Azure Portal with these settings:

   * **Source**: GitHub
   * **Repo**: `JohnWillisUK/Hedgehog-Lab-Test`
   * **Branch**: `main`
   * **App location**: `frontend`
   * **Output location**: `build`
   * **API location**: *(leave blank)*
3. Azure generates a GitHub Actions workflow to build and deploy the frontend automatically
4. React app is built with `npm run build` and deployed to Azure

---

## 3. Backend Deployment (FastAPI)

The backend is deployed to **Azure App Service for Linux** and runs in a Docker container pulled from GHCR.

### CI/CD Workflow:

* GitHub Actions builds the Docker image and pushes it to GHCR on every push to `main`
* Image is tagged as:

  * `ghcr.io/johnwillisuk/hedgehog-lab-test-backend:latest`

### Terraform Configuration:

* Uses `azurerm_linux_web_app` with:

  * `DOCKER_CUSTOM_IMAGE_NAME` set to the GHCR image URL
  * Environment variables for DB connection
  * Port `8000` exposed as `WEBSITES_PORT`

---

## 4. Database Deployment

Provisioned using `azurerm_postgresql_flexible_server`:

* Deployed in `westeurope`
* Admin user/password from Terraform variables
* Firewall rule added to allow access from App Service

---

## 5. Infrastructure Management (Terraform)

All infrastructure is described in `infra/main.tf` and related files.

### To Deploy:

```bash
cd infra
az login
terraform init
terraform apply
```

### To Destroy:

```bash
terraform destroy
```

---

## 6. Security & Config

* Secrets like `POSTGRES_PASSWORD` are passed via App Settings (could be improved using Key Vault)
* `azurerm_postgresql_flexible_server` currently allows public access — production deployments should use VNet integration or IP whitelisting
* Static Web App is public by default

---

## 7. Improvements

Further enhancements could include:

* Auto-deploying Terraform via GitHub Actions with environment approvals
* Moving database secrets to Azure Key Vault
* Adding monitoring (App Insights, logging)
* Locking down DB with IP restrictions or private networking
* Versioned backend images per commit SHA

---

## 8. Summary

This deployment uses a clean separation of CI/CD and infrastructure provisioning:

* GitHub Actions handles app packaging
* Terraform provisions and manages infrastructure
* Azure services handle scaling, availability, and hosting

The approach is scalable, repeatable, and easily extended.
