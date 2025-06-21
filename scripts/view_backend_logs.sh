#!/bin/bash
set -e
container_name="hedgehog-lab-test-backend-1"
if docker ps | grep -q "$container_name"; then
  docker logs "$container_name"
else
  echo "Backend container was never started!"
  exit 1
fi
