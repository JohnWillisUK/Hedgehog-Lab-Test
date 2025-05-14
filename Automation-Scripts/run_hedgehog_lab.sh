#!/bin/bash
# ================================================
# Script to Set Up and Run Hedgehog Lab Containers
# ================================================

# How to Use:
# 1. Ensure you have Git, Docker, and Docker Compose installed.
# 2. Give this script execution permissions using: chmod +x run_hedgehog_lab.sh
# 3. Run the script using: ./run_hedgehog_lab.sh

# Clone the repo
git clone https://github.com/JohnWillisUK/Hedgehog-Lab-Test.git

# Navigate into the project directory
cd Hedgehog-Lab-Test

# Build and run the containers
docker-compose up --build

# Notify user
echo "Containers are up and running. Visit http://localhost:3000 to use the app."
echo "To close the containers, run: docker-compose down -v in a BASH Terminal."
