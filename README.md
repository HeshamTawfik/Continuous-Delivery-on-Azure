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

See [here](https://youtu.be/zaF4OrpQsPU) for a YouTube video demonstrating the project.

# Instructions

## Deploy the app in Azure Cloud Shell
In Azure Cloud Shell, clone the repo:
```
git clone git@github.com:HeshamTawfik/Continuous-Delivery-on-Azure.git
```
![Screenshot from 2023-11-18 20-18-32](https://github.com/HeshamTawfik/Continuous-Delivery-on-Azure/assets/33587812/1f693722-46ef-4771-bc2b-cca53a4ae56e)

Change into the new directory:
```
cd Continuous-Delivery-on-Azure
```
Create a virtual environment:
```
make setup
```
![Screenshot from 2023-11-18 20-27-49](https://github.com/HeshamTawfik/Continuous-Delivery-on-Azure/assets/33587812/bcb8c18e-a33b-45bd-92cd-94538fe2aa45)

Activate the virtual environment:
```
source ~/.udacity-devops/bin/activate
```
![Screenshot from 2023-11-18 21-53-34](https://github.com/HeshamTawfik/Continuous-Delivery-on-Azure/assets/33587812/62dfb2a3-7704-42a5-88e4-b36b18e526a8)

Install dependencies in the virtual environment and run tests:
```
make all
```
![Screenshot from 2023-11-18 20-28-37](https://github.com/HeshamTawfik/Continuous-Delivery-on-Azure/assets/33587812/d2ff3e69-e234-4fbc-9bc7-4dcbf04d664d)

Start the application in the local environment:
```
python app.py
```

Open a separate Cloud Shell and test that the app is working:
```
./make_prediction.sh
```
![Screenshot from 2023-11-18 20-29-19](https://github.com/HeshamTawfik/Continuous-Delivery-on-Azure/assets/33587812/e2b4d13a-7276-4b97-bdcb-1e6a3584ecea)


## Deploy the app to an Azure App Service

Create an App Service in Azure. In this example the App Service is called Continuous-Delivery-on-Azure and the resource group is called Continuous-Delivery-on-Azure-project:
```
az webapp up -n Continuous-Delivery-on-Azure -g Continuous-Delivery-on-Azure-project
```
![Screenshot from 2023-11-18 20-31-48](https://github.com/HeshamTawfik/Continuous-Delivery-on-Azure/assets/33587812/9552b3be-00e7-49da-8072-f9d60a2870b9)

Next, create the pipeline in Azure DevOps. More information on this process can be found [here](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops&WT.mc_id=udacity_learn-wwl). The basic steps to set up the pipeline are:

- Go to [https://dev.azure.com](https://dev.azure.com) and sign in.
- Create a new private project.
- Under Project Settings create a new service connection to Azure Resource Manager, scoped to your subscription and resource group.
- Create a new pipeline linked to your GitHub repo.

![Screenshot from 2023-11-18 21-05-23](https://github.com/HeshamTawfik/Continuous-Delivery-on-Azure/assets/33587812/ea160aef-23d2-4981-a76c-97f9386fde97)

To test the app running in Azure App Service, edit line 28 of the make_predict_azure_app.sh script with the DNS name of your app. Then run the script:
```
./make_predict_azure_app.sh 
```
![Screenshot from 2023-11-18 22-00-52](https://github.com/HeshamTawfik/Continuous-Delivery-on-Azure/assets/33587812/8e0285fc-a441-4158-bf84-f4d04108ede2)

View the app logs:
```
az webapp log tail -g Continuous-Delivery-on-Azure-project --name Continuous-Delivery-on-Azure
```
![Screenshot from 2023-11-18 21-53-34](https://github.com/HeshamTawfik/Continuous-Delivery-on-Azure/assets/33587812/1999693b-fb1d-4800-a0aa-b6e1740e475d)

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

![Screenshot from 2023-11-18 21-51-05](https://github.com/HeshamTawfik/Continuous-Delivery-on-Azure/assets/33587812/6efe12d1-6f94-4888-a54d-598f90bf8c38)


![Screenshot from 2023-11-18 21-50-22](https://github.com/HeshamTawfik/Continuous-Delivery-on-Azure/assets/33587812/a4710924-5bd8-4642-81ca-271b54e785e5)



## Future improvements

Currently, there is only a single branch in GitHub. In the future it would be good to create multiple branches, so code can initially be tested and deployed in a staging environment. If it works correctly in the staging environment the changes could then be merged into the production branch and the code deployed into the production environment.
