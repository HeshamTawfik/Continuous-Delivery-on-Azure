#!/usr/bin/env bash
# this script contain all Azure CLI commands you used

# Create an App Service in Azure. In this example the App Service is called jose-flaskpipelines and the resource group is called jose-udacity-project. The result take a few minutes:
az webapp up -n jose-flaskpipelines -g jose-udacity-project

# view the logs:
az webapp log tail -n jose-flaskpipelines -g jose-udacity-project

