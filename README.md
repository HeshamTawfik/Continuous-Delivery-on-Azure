[![Python application test with Github Actions](https://github.com/HeshamTawfik/Continuous-Delivery-on-Azure/actions/workflows/pythonapp.yml/badge.svg)](https://github.com/HeshamTawfik/Continuous-Delivery-on-Azure/actions/workflows/pythonapp.yml)

By Hesham Tawfik

16/11/2023

# Introduction

This project contains a python application that is designed to predict housing prices in Boston (I did not create the python app myself). This repo will enable you to:
- Deploy the app in Azure CloudShell
- Deploy the app as an Azure App Service

Any commits to the GitHub repo trigger automated code testing using GitHub Actions. A pipeline has been created in Azure DevOps, and the updated code is also automatically tested in Azure DevOps and deployed to the Azure App Service. 

Here is an architectural diagram:
![screenshot-architectural-diagram2](https://github.com/HeshamTawfik/Continuous-Delivery-on-Azure/assets/33587812/eef19f85-a42e-4301-aa22-a99fcdf0ac53)


A [Trello](https://trello.com/invite/b/JB4a3Vp9/ATTI173d4a5d11e32f31144b64ae13b48c54578F3A5B/building-ci-cd-pipeline) board has been created to keep track of tasks to be completed.

A [spreadsheet](project-schedule.xlsx) has been created to manage the project schedule.

# Instructions

## Deploy the app in Azure Cloud Shell
In Azure Cloud Shell, clone the repo:
```
git clone git@github.com:HeshamTawfik/Continuous-Delivery-on-Azure.git
```
Change into the new directory:
```
cd Continuous-Delivery-on-Azure
```

Create a virtual environment:
```
make setup
```

Activate the virtual environment:
```
source ~/.udacity-devops/bin/activate
```

Install dependencies in the virtual environment and run tests:
```
make all
```
Start the application in the local environment:
```
python app.py
```

Open a separate Cloud Shell and test that the app is working:
```
./make_prediction.sh
```

The output should match the below:





## Deploy the app to an Azure App Service

Create an App Service in Azure. In this example the App Service is called Continuous-Delivery-on-Azure and the resource group is called Continuous-Delivery-on-Azure-project:
```
az webapp up -n Continuous-Delivery-on-Azure -g Continuous-Delivery-on-Azure-project
```

Next, create the pipeline in Azure DevOps. More information on this process can be found [here](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops&WT.mc_id=udacity_learn-wwl). The basic steps to set up the pipeline are:

- Go to [https://dev.azure.com](https://dev.azure.com) and sign in.
- Create a new private project.
- Under Project Settings create a new service connection to Azure Resource Manager, scoped to your subscription and resource group.
- Create a new pipeline linked to your GitHub repo.

To test the app running in Azure App Service, edit line 28 of the make_predict_azure_app.sh script with the DNS name of your app. Then run the script:
```
./make_predict_azure_app.sh 
```

View the app logs:
```
az webapp log tail -g Continuous-Delivery-on-Azure-project --name Continuous-Delivery-on-Azure
```

## Load testing

We can use locust to do a load test against our application. In this example we will do a load test against the app running locally rather than in Azure. 

Install locust:
```
pip install locust
```
Start locust:
```
locust
```
Open a browser and go to [http://localhost:8089](http://localhost:8089). Enter the total number of users to simulate, spawn rate, set the host to localhost:5000, and click Start Swarming:

You can then watch the load test:






## Future improvements

Currently, there is only a single branch in GitHub. In the future it would be good to create multiple branches, so code can initially be tested and deployed in a staging environment. If it works correctly in the staging environment the changes could then be merged into the production branch and the code deployed into the production environment.
