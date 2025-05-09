Azure Deployment Guide 🚀
Deploying a full-stack application on Azure using Docker, Terraform, and GitHub Actions.

Step 1: Set Up Azure Resources with Terraform 🏗️
1. Install Terraform
Download and install Terraform from the official website: Install Terraform

2. Log in to Azure
Authenticate with the Azure CLI:

-------------bash-------------
 
az login
--------------------------------------------------------
 
3. Initialize Terraform
Navigate to your infra directory and initialize Terraform:

-------------bash-------------
 
cd infra
terraform init
--------------------------------------------------------
 
4. Apply Terraform Configuration
Deploy required Azure resources (Resource Group, PostgreSQL, App Service, etc.):

-------------bash-------------
 
terraform apply
--------------------------------------------------------
 
✅ Confirm when prompted.

Step 2: Build and Push Docker Images 🐳
1. Build the Frontend Docker Image
-------------bash-------------
    
docker build -t your-frontend-image ./frontend
--------------------------------------------------------
 
3. Build the Backend Docker Image
-------------bash-------------
    
docker build -t your-backend-image ./backend
--------------------------------------------------------
 
5. Log in to GitHub Container Registry (GHCR)
Authenticate Docker with GHCR:

-------------bash-------------
 
echo "${{ secrets.GITHUB_TOKEN }}" | docker login ghcr.io -u ${{ github.actor }} --password-stdin
--------------------------------------------------------
 
4. Tag & Push Backend Image to GHCR
-------------bash-------------
    
docker tag your-backend-image ghcr.io/your-username/your-backend-image:latest
docker push ghcr.io/your-username/your-backend-image:latest
--------------------------------------------------------
 
Step 3: Set Up CI/CD with GitHub Actions ⚙️
1. Create a GitHub Repository
Push your project to a GitHub repository if you haven’t already.

2. Set Up GitHub Actions Workflow
Ensure your GitHub Actions workflow is in .github/workflows/ci-pipeline.yml. This will trigger on every push to the main branch.

Step 4: Deploy Frontend & Backend on Azure 🌐
1. Frontend Deployment
Frontend is automatically deployed to Azure Static Web Apps once the CI/CD workflow completes.

2. Backend Deployment
Backend is deployed to Azure App Service using the Docker image from GHCR.

🔹 Environment variables, including database credentials, are set automatically during deployment.

Step 5: Verify the Deployment ✅
1. Frontend
Access the deployed frontend via Azure Static Web Apps URL.

2. Backend
Verify that the backend is running by checking the health endpoint:

-------------bash-------------
 
http://<your-backend-url>/healthz
--------------------------------------------------------
 

Conclusion 🎯
By following these steps, you've successfully deployed a full-stack application with:

✅ CI/CD pipeline for continuous deployment ✅ Infrastructure as Code (IaC) using Terraform ✅ Cloud deployment on Azure
