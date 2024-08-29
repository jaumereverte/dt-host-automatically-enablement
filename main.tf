resource "dynatrace_automation_workflow" "Enable_Monitoring" {
  description = "Workflow to automatically enable monitoring for hosts"
  actor       = var.dt_owner
  title       = "Enable monitoring"
  owner       = var.dt_owner
  private     = true
  tasks {
    task {
      name        = "list_hosts"
      description = "Executes DQL query to retrieve list of hosts"
      action      = "dynatrace.automations:execute-dql-query"
      input = jsonencode({
        "query" : var.hostFilterQuery
      })
      position {
        x = 0
        y = 1
      }
    }
    task {
      name        = "activate_monitoring"
      description = "Build a custom task running js Code to enable the hosts"
      action      = "dynatrace.automations:run-javascript"
      input = jsonencode({
      "script" : "// optional import of sdk modules\n          import { executionsClient } from '@dynatrace-sdk/client-automation';\n          import { settingsObjectsClient } from\n          '@dynatrace-sdk/client-classic-environment-v2';\n          export default async function ({ execution_id }) {\n            console.log('Retrieving previous task execution results for:', { executionId: execution_id, id: 'list_hosts' });\n            const taskExecution = await executionsClient.getTaskExecution({ executionId: execution_id, id: 'list_hosts' });\n            if (!taskExecution || !taskExecution.hasOwnProperty('result')) {\n                console.error(taskExecution);\n                throw new Error('executionsClient.getTaskExecution failed. Can not get the result of the previous execution.');\n            }\n            const taskExecutionResult = taskExecution.result;\n            if (!taskExecutionResult || !taskExecutionResult.hasOwnProperty('records')) {\n                console.error(taskExecutionResult);\n                throw new Error('executionsClient.getTaskExecution failed. Can not get the records of the previous execution.');\n            }\n            const hostList = taskExecutionResult.records;\n            for (var index in hostList){\n              var hostID = hostList[index].id;\n              console.log('Trying to enable Host: ', hostID);\n              const data =\n                await settingsObjectsClient.postSettingsObjects({\n                  body: [\n                  {\n                    externalId: 'string',\n                    schemaId: 'builtin:host.monitoring',\n                    schemaVersion: '1.4',\n                    scope: hostList[index].id,\n                    value: { 'enabled': true },\n                  },\n                  ],\n                });\n              var resultCode = data[0].code;\n              if (resultCode == 200){\n                console.log('Enabled Host: ', hostID);\n              } else {\n                throw new Error('Could not enable monitoring fot Host: , hostID);\n              }\n            }\n          }" })
      position {
        x = 0
        y = 2
      }
    }
  }
  trigger {
    schedule {
      active    = true
      rule      = null
      time_zone = "Europe/Madrid"
      trigger {
        time = var.enableTime
      }
      filter_parameters {
        earliest_start = var.startDate
      }
    }
  }
}

resource "dynatrace_automation_workflow" "Disable_Monitoring" {
  description = "Workflow to automatically disable monitoring for hosts"
  actor       = var.dt_owner
  title       = "Disable monitoring"
  owner       = var.dt_owner
  private     = true
  tasks {
    task {
      name        = "list_hosts"
      description = "Executes DQL query to retrieve list of hosts"
      action      = "dynatrace.automations:execute-dql-query"
      input = jsonencode({
        "query" : var.hostFilterQuery
      })
      position {
        x = 0
        y = 1
      }
    }
    task {
      name        = "disable_monitoring"
      description = "Build a custom task running js Code to disable the hosts"
      action      = "dynatrace.automations:run-javascript"
      input = jsonencode({
        "script" : "// optional import of sdk modules\n          import { executionsClient } from '@dynatrace-sdk/client-automation';\n          import { settingsObjectsClient } from\n          '@dynatrace-sdk/client-classic-environment-v2';\n          export default async function ({ execution_id }) {\n            console.log('Retrieving previous task execution results for:', { executionId: execution_id, id: 'list_hosts' });\n            const taskExecution = await executionsClient.getTaskExecution({ executionId: execution_id, id: 'list_hosts' });\n            if (!taskExecution || !taskExecution.hasOwnProperty('result')) {\n                console.error(taskExecution);\n                throw new Error('executionsClient.getTaskExecution failed. Can not get the result of the previous execution.');\n            }\n            const taskExecutionResult = taskExecution.result;\n            if (!taskExecutionResult || !taskExecutionResult.hasOwnProperty('records')) {\n                console.error(taskExecutionResult);\n                throw new Error('executionsClient.getTaskExecution failed. Can not get the records of the previous execution.');\n            }\n            const hostList = taskExecutionResult.records;\n            for (var index in hostList){\n              var hostID = hostList[index].id;\n              console.log('Trying to disable Host: ', hostID);\n              const data =\n                await settingsObjectsClient.postSettingsObjects({\n                  body: [\n                  {\n                    externalId: 'string',\n                    schemaId: 'builtin:host.monitoring',\n                    schemaVersion: '1.4',\n                    scope: hostList[index].id,\n                    value: { 'enabled': false },\n                  },\n                  ],\n                });\n              var resultCode = data[0].code;\n              if (resultCode == 200){\n                console.log('Disabled Host: ', hostID);\n              } else {\n                throw new Error('Could not disable monitoring fot Host: ', hostID);\n              }\n            }\n          }"
      })
      position {
        x = 0
        y = 2
      }
    }
  }
  trigger {
    schedule {
      active    = true
      rule      = null
      time_zone = "Europe/Madrid"
      trigger {
        time = disableTime
      }
      filter_parameters {
        earliest_start = var.startDate
      }
    }
  }
}
