#!/usr/bin/env bash
# this script contain all Azure CLI commands you used

# Create an App Service in Azure. In this example the App Service is called Continuous-Delivery-on-Azure and the resource group is called Continuous-Delivery-on-Azure-project. The result take a few minutes:
az webapp up -n Continuous-Delivery-on-Azure -g Continuous-Delivery-on-Azure-project

# view the logs:
az webapp log tail -n Continuous-Delivery-on-Azure -g Continuous-Delivery-on-Azure-project

