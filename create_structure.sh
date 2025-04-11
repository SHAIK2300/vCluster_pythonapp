#!/bin/bash

# Define base directory
BASE_DIR="vCluster_pythonapp"

# Create directory structure
mkdir -p $BASE_DIR/.github/workflows
mkdir -p $BASE_DIR/app
mkdir -p $BASE_DIR/charts/python-app/templates

# Create empty files
touch $BASE_DIR/.github/workflows/ci.yaml
touch $BASE_DIR/.github/workflows/cd.yaml

touch $BASE_DIR/app/main.py
touch $BASE_DIR/app/requirements.txt
touch $BASE_DIR/app/Dockerfile

touch $BASE_DIR/charts/python-app/Chart.yaml
touch $BASE_DIR/charts/python-app/values.yaml
touch $BASE_DIR/charts/python-app/templates/deployment.yaml
touch $BASE_DIR/charts/python-app/templates/service.yaml
touch $BASE_DIR/charts/python-app/templates/ingress.yaml

touch $BASE_DIR/README.md

echo "Project structure for '$BASE_DIR' created successfully."
