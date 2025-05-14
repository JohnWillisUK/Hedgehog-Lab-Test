# ================================================
# Script to Set Up and Run Hedgehog Lab Containers
# ================================================

# How to Use:
# 1. Ensure you have Git, Docker, and Docker Compose installed.
# 2. Open a PowerShell terminal and execute: `./run_hedgehog_lab.ps1`

# Clone the repo
git clone https://github.com/JohnWillisUK/Hedgehog-Lab-Test.git

# Navigate into the project directory
Set-Location -Path Hedgehog-Lab-Test

# Build and run the containers
docker-compose up --build

# Notify user
Write-Host "Containers are up and running. Visit http://localhost:3000 to use the app."
Write-Host "To close the containers, run: docker-compose down -v in a PowerShell terminal."
