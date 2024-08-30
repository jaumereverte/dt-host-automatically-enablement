# DT-Host-Automated-Monitoring

This repository provides the necessary configuration to automate the activation and deactivation of host monitoring within your environment based on specified time periods. For instance, monitoring can be activated during working hours and deactivated afterward. The entire configuration process is automated using the Dynatrace Terraform provider.

> [!NOTE]
> Please note that this project is currently under development, and changes are expected.

## Getting started with Host Automated Monitoring

To correctly deploy the workflows, follow these steps:

1. Create a `<file_name>.tfvars` file. In this file, you need to include the following variables: `dt_env_url`, `dt_api_token`, `automation_client_id`, and `automation_client_secret`.
2. Modify the `variables.tf` file to adapt the script to your specific use case by setting the appropriate variables. These are the available variable for you to change: `hostFilterQuery`, `enableTime`, `disableTime`, `startDate` and `dt_owner`.
3. Once these changes are made, use Terraform to deploy the workflows:
   - `terraform init` - Installs the Dynatrace provider.
   - `terraform plan` - Displays the proposed changes that will be applied to your environment.
   - `terraform apply` - Applies the changes described in the Terraform plan.

## Future improvements - TO DO

- [] Implement the loop option in Dynatrace JavaScript instead of repeating the same task.
- [] Develop an additional scenario to modify the monitoring type.
- [] Consolidate the two workflows into a single workflow.
- [] Create an execution rule to run workloads only on workdays.

Author: Jaume Reverte - jaume.reverte@dynatrace.com
