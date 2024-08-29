# DT-Host-Automated-Monitoring

This repository will help you deploy a configuration that will activate and deactivate the monitoring of hosts inside your Environment based in a period of time. So for example it will activate monitoring during working hours and will deactivate after working hours. All configuration is deployed automatically using Dynatrace Terraform provider.

Be aware that this project is under construction and you will se changes.

## Getting started with Host Automated Monitoring

In order to deploy correctly the Workflows, follow the next steps:

1. Create a file <file_name>.tfvars, in this file you need to add the dt_env_url, dt_api_token, automation_client_id and automation_client_secret
2. In the variables.tf adapt the different variables to adapt the script to your use case
3. Once you have done this changes, you have to use terraform to deploy the Workflows
   - terraform init - will install the Dynatrace provider
   - terraform plan - will show in console the changes that will happen inside your enviornment after using the Terraform
   - terraform apply - will apply the changes descrived in terraform plan

## Future improvements

- Use loop option from Dynatrace Javascript instead of looping in the same task
- Have a second scenario to change the monitoring type
- Group the two Workflows in only one

Author: Jaume Reverte - jaume.reverte@dynatrace.com
