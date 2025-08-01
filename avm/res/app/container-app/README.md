# Container Apps `[Microsoft.App/containerApps]`

This module deploys a Container App.

## Navigation

- [Resource Types](#Resource-Types)
- [Usage examples](#Usage-examples)
- [Parameters](#Parameters)
- [Outputs](#Outputs)
- [Cross-referenced modules](#Cross-referenced-modules)
- [Data Collection](#Data-Collection)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.App/containerApps` | [2025-01-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.App/2025-01-01/containerApps) |
| `Microsoft.App/containerApps/authConfigs` | [2025-01-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.App/2025-01-01/containerApps/authConfigs) |
| `Microsoft.Authorization/locks` | [2020-05-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2020-05-01/locks) |
| `Microsoft.Authorization/roleAssignments` | [2022-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2022-04-01/roleAssignments) |
| `Microsoft.Insights/diagnosticSettings` | [2021-05-01-preview](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Insights/2021-05-01-preview/diagnosticSettings) |

## Usage examples

The following section provides usage examples for the module, which were used to validate and deploy the module successfully. For a full reference, please review the module's test folder in its repository.

>**Note**: Each example lists all the required parameters first, followed by the rest - each in alphabetical order.

>**Note**: To reference the module, please use the following syntax `br/public:avm/res/app/container-app:<version>`.

- [Using only defaults](#example-1-using-only-defaults)
- [Without ingress enabled](#example-2-without-ingress-enabled)
- [Using large parameter set](#example-3-using-large-parameter-set)
- [VNet integrated container app deployment](#example-4-vnet-integrated-container-app-deployment)
- [WAF-aligned](#example-5-waf-aligned)

### Example 1: _Using only defaults_

This instance deploys the module with the minimum set of required parameters.


<details>

<summary>via Bicep module</summary>

```bicep
module containerApp 'br/public:avm/res/app/container-app:<version>' = {
  name: 'containerAppDeployment'
  params: {
    // Required parameters
    containers: [
      {
        image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
        name: 'simple-hello-world-container'
        resources: {
          cpu: '<cpu>'
          memory: '0.5Gi'
        }
      }
    ]
    environmentResourceId: '<environmentResourceId>'
    name: 'acamin001'
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "containers": {
      "value": [
        {
          "image": "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest",
          "name": "simple-hello-world-container",
          "resources": {
            "cpu": "<cpu>",
            "memory": "0.5Gi"
          }
        }
      ]
    },
    "environmentResourceId": {
      "value": "<environmentResourceId>"
    },
    "name": {
      "value": "acamin001"
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/app/container-app:<version>'

// Required parameters
param containers = [
  {
    image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
    name: 'simple-hello-world-container'
    resources: {
      cpu: '<cpu>'
      memory: '0.5Gi'
    }
  }
]
param environmentResourceId = '<environmentResourceId>'
param name = 'acamin001'
```

</details>
<p>

### Example 2: _Without ingress enabled_

This instance deploys the module with ingress traffic completely disabled.


<details>

<summary>via Bicep module</summary>

```bicep
module containerApp 'br/public:avm/res/app/container-app:<version>' = {
  name: 'containerAppDeployment'
  params: {
    // Required parameters
    containers: [
      {
        image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
        name: 'simple-hello-world-container'
        resources: {
          cpu: '<cpu>'
          memory: '0.5Gi'
        }
      }
    ]
    environmentResourceId: '<environmentResourceId>'
    name: 'acapriv001'
    // Non-required parameters
    disableIngress: true
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "containers": {
      "value": [
        {
          "image": "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest",
          "name": "simple-hello-world-container",
          "resources": {
            "cpu": "<cpu>",
            "memory": "0.5Gi"
          }
        }
      ]
    },
    "environmentResourceId": {
      "value": "<environmentResourceId>"
    },
    "name": {
      "value": "acapriv001"
    },
    // Non-required parameters
    "disableIngress": {
      "value": true
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/app/container-app:<version>'

// Required parameters
param containers = [
  {
    image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
    name: 'simple-hello-world-container'
    resources: {
      cpu: '<cpu>'
      memory: '0.5Gi'
    }
  }
]
param environmentResourceId = '<environmentResourceId>'
param name = 'acapriv001'
// Non-required parameters
param disableIngress = true
```

</details>
<p>

### Example 3: _Using large parameter set_

This instance deploys the module with most of its features enabled.


<details>

<summary>via Bicep module</summary>

```bicep
module containerApp 'br/public:avm/res/app/container-app:<version>' = {
  name: 'containerAppDeployment'
  params: {
    // Required parameters
    containers: [
      {
        env: [
          {
            name: 'ContainerAppStoredSecretName'
            secretRef: 'containerappstoredsecret'
          }
          {
            name: 'ContainerAppKeyVaultStoredSecretName'
            secretRef: 'keyvaultstoredsecret'
          }
        ]
        image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
        name: 'simple-hello-world-container'
        probes: [
          {
            httpGet: {
              httpHeaders: [
                {
                  name: 'Custom-Header'
                  value: 'Awesome'
                }
              ]
              path: '/health'
              port: 8080
            }
            initialDelaySeconds: 3
            periodSeconds: 3
            type: 'Liveness'
          }
        ]
        resources: {
          cpu: '<cpu>'
          memory: '0.5Gi'
        }
      }
    ]
    environmentResourceId: '<environmentResourceId>'
    name: 'acamax001'
    // Non-required parameters
    activeRevisionsMode: 'Single'
    authConfig: {
      globalValidation: {
        unauthenticatedClientAction: 'Return401'
      }
      httpSettings: {
        requireHttps: true
      }
      platform: {
        enabled: true
      }
    }
    identitySettings: [
      {
        identity: '<identity>'
        lifecycle: 'None'
      }
    ]
    initContainersTemplate: [
      {
        image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
        name: 'init-container'
        resources: {
          cpu: '<cpu>'
          memory: '0.5Gi'
        }
      }
    ]
    location: '<location>'
    lock: {
      kind: 'CanNotDelete'
      name: 'myCustomLockName'
    }
    managedIdentities: {
      userAssignedResourceIds: [
        '<managedIdentityResourceId>'
      ]
    }
    roleAssignments: [
      {
        name: 'e9bac1ee-aebe-4513-9337-49e87a7be05e'
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Owner'
      }
      {
        name: '<name>'
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
      }
      {
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: '<roleDefinitionIdOrName>'
      }
    ]
    runtime: {
      java: {
        enableMetrics: true
      }
    }
    scaleSettings: {
      cooldownPeriod: 500
      maxReplicas: 11
      minReplicas: 4
      pollingInterval: 45
    }
    secrets: [
      {
        name: 'containerappstoredsecret'
        value: '<value>'
      }
      {
        identity: '<identity>'
        keyVaultUrl: '<keyVaultUrl>'
        name: 'keyvaultstoredsecret'
      }
    ]
    service: {
      type: 'Web'
    }
    tags: {
      Env: 'test'
      'hidden-title': 'This is visible in the resource name'
    }
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "containers": {
      "value": [
        {
          "env": [
            {
              "name": "ContainerAppStoredSecretName",
              "secretRef": "containerappstoredsecret"
            },
            {
              "name": "ContainerAppKeyVaultStoredSecretName",
              "secretRef": "keyvaultstoredsecret"
            }
          ],
          "image": "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest",
          "name": "simple-hello-world-container",
          "probes": [
            {
              "httpGet": {
                "httpHeaders": [
                  {
                    "name": "Custom-Header",
                    "value": "Awesome"
                  }
                ],
                "path": "/health",
                "port": 8080
              },
              "initialDelaySeconds": 3,
              "periodSeconds": 3,
              "type": "Liveness"
            }
          ],
          "resources": {
            "cpu": "<cpu>",
            "memory": "0.5Gi"
          }
        }
      ]
    },
    "environmentResourceId": {
      "value": "<environmentResourceId>"
    },
    "name": {
      "value": "acamax001"
    },
    // Non-required parameters
    "activeRevisionsMode": {
      "value": "Single"
    },
    "authConfig": {
      "value": {
        "globalValidation": {
          "unauthenticatedClientAction": "Return401"
        },
        "httpSettings": {
          "requireHttps": true
        },
        "platform": {
          "enabled": true
        }
      }
    },
    "identitySettings": {
      "value": [
        {
          "identity": "<identity>",
          "lifecycle": "None"
        }
      ]
    },
    "initContainersTemplate": {
      "value": [
        {
          "image": "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest",
          "name": "init-container",
          "resources": {
            "cpu": "<cpu>",
            "memory": "0.5Gi"
          }
        }
      ]
    },
    "location": {
      "value": "<location>"
    },
    "lock": {
      "value": {
        "kind": "CanNotDelete",
        "name": "myCustomLockName"
      }
    },
    "managedIdentities": {
      "value": {
        "userAssignedResourceIds": [
          "<managedIdentityResourceId>"
        ]
      }
    },
    "roleAssignments": {
      "value": [
        {
          "name": "e9bac1ee-aebe-4513-9337-49e87a7be05e",
          "principalId": "<principalId>",
          "principalType": "ServicePrincipal",
          "roleDefinitionIdOrName": "Owner"
        },
        {
          "name": "<name>",
          "principalId": "<principalId>",
          "principalType": "ServicePrincipal",
          "roleDefinitionIdOrName": "b24988ac-6180-42a0-ab88-20f7382dd24c"
        },
        {
          "principalId": "<principalId>",
          "principalType": "ServicePrincipal",
          "roleDefinitionIdOrName": "<roleDefinitionIdOrName>"
        }
      ]
    },
    "runtime": {
      "value": {
        "java": {
          "enableMetrics": true
        }
      }
    },
    "scaleSettings": {
      "value": {
        "cooldownPeriod": 500,
        "maxReplicas": 11,
        "minReplicas": 4,
        "pollingInterval": 45
      }
    },
    "secrets": {
      "value": [
        {
          "name": "containerappstoredsecret",
          "value": "<value>"
        },
        {
          "identity": "<identity>",
          "keyVaultUrl": "<keyVaultUrl>",
          "name": "keyvaultstoredsecret"
        }
      ]
    },
    "service": {
      "value": {
        "type": "Web"
      }
    },
    "tags": {
      "value": {
        "Env": "test",
        "hidden-title": "This is visible in the resource name"
      }
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/app/container-app:<version>'

// Required parameters
param containers = [
  {
    env: [
      {
        name: 'ContainerAppStoredSecretName'
        secretRef: 'containerappstoredsecret'
      }
      {
        name: 'ContainerAppKeyVaultStoredSecretName'
        secretRef: 'keyvaultstoredsecret'
      }
    ]
    image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
    name: 'simple-hello-world-container'
    probes: [
      {
        httpGet: {
          httpHeaders: [
            {
              name: 'Custom-Header'
              value: 'Awesome'
            }
          ]
          path: '/health'
          port: 8080
        }
        initialDelaySeconds: 3
        periodSeconds: 3
        type: 'Liveness'
      }
    ]
    resources: {
      cpu: '<cpu>'
      memory: '0.5Gi'
    }
  }
]
param environmentResourceId = '<environmentResourceId>'
param name = 'acamax001'
// Non-required parameters
param activeRevisionsMode = 'Single'
param authConfig = {
  globalValidation: {
    unauthenticatedClientAction: 'Return401'
  }
  httpSettings: {
    requireHttps: true
  }
  platform: {
    enabled: true
  }
}
param identitySettings = [
  {
    identity: '<identity>'
    lifecycle: 'None'
  }
]
param initContainersTemplate = [
  {
    image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
    name: 'init-container'
    resources: {
      cpu: '<cpu>'
      memory: '0.5Gi'
    }
  }
]
param location = '<location>'
param lock = {
  kind: 'CanNotDelete'
  name: 'myCustomLockName'
}
param managedIdentities = {
  userAssignedResourceIds: [
    '<managedIdentityResourceId>'
  ]
}
param roleAssignments = [
  {
    name: 'e9bac1ee-aebe-4513-9337-49e87a7be05e'
    principalId: '<principalId>'
    principalType: 'ServicePrincipal'
    roleDefinitionIdOrName: 'Owner'
  }
  {
    name: '<name>'
    principalId: '<principalId>'
    principalType: 'ServicePrincipal'
    roleDefinitionIdOrName: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
  }
  {
    principalId: '<principalId>'
    principalType: 'ServicePrincipal'
    roleDefinitionIdOrName: '<roleDefinitionIdOrName>'
  }
]
param runtime = {
  java: {
    enableMetrics: true
  }
}
param scaleSettings = {
  cooldownPeriod: 500
  maxReplicas: 11
  minReplicas: 4
  pollingInterval: 45
}
param secrets = [
  {
    name: 'containerappstoredsecret'
    value: '<value>'
  }
  {
    identity: '<identity>'
    keyVaultUrl: '<keyVaultUrl>'
    name: 'keyvaultstoredsecret'
  }
]
param service = {
  type: 'Web'
}
param tags = {
  Env: 'test'
  'hidden-title': 'This is visible in the resource name'
}
```

</details>
<p>

### Example 4: _VNet integrated container app deployment_

This instance deploys the container app in a managed environment with a virtual network using TCP ingress.


<details>

<summary>via Bicep module</summary>

```bicep
module containerApp 'br/public:avm/res/app/container-app:<version>' = {
  name: 'containerAppDeployment'
  params: {
    // Required parameters
    containers: [
      {
        image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
        name: 'simple-hello-world-container'
        resources: {
          cpu: '<cpu>'
          memory: '0.5Gi'
        }
      }
    ]
    environmentResourceId: '<environmentResourceId>'
    name: 'acavnet001'
    // Non-required parameters
    additionalPortMappings: [
      {
        exposedPort: 8080
        external: false
        targetPort: 8080
      }
    ]
    ingressAllowInsecure: false
    ingressExternal: false
    ingressTargetPort: 80
    ingressTransport: 'tcp'
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "containers": {
      "value": [
        {
          "image": "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest",
          "name": "simple-hello-world-container",
          "resources": {
            "cpu": "<cpu>",
            "memory": "0.5Gi"
          }
        }
      ]
    },
    "environmentResourceId": {
      "value": "<environmentResourceId>"
    },
    "name": {
      "value": "acavnet001"
    },
    // Non-required parameters
    "additionalPortMappings": {
      "value": [
        {
          "exposedPort": 8080,
          "external": false,
          "targetPort": 8080
        }
      ]
    },
    "ingressAllowInsecure": {
      "value": false
    },
    "ingressExternal": {
      "value": false
    },
    "ingressTargetPort": {
      "value": 80
    },
    "ingressTransport": {
      "value": "tcp"
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/app/container-app:<version>'

// Required parameters
param containers = [
  {
    image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
    name: 'simple-hello-world-container'
    resources: {
      cpu: '<cpu>'
      memory: '0.5Gi'
    }
  }
]
param environmentResourceId = '<environmentResourceId>'
param name = 'acavnet001'
// Non-required parameters
param additionalPortMappings = [
  {
    exposedPort: 8080
    external: false
    targetPort: 8080
  }
]
param ingressAllowInsecure = false
param ingressExternal = false
param ingressTargetPort = 80
param ingressTransport = 'tcp'
```

</details>
<p>

### Example 5: _WAF-aligned_

This instance deploys the module in alignment with the best-practices of the Azure Well-Architected Framework.


<details>

<summary>via Bicep module</summary>

```bicep
module containerApp 'br/public:avm/res/app/container-app:<version>' = {
  name: 'containerAppDeployment'
  params: {
    // Required parameters
    containers: [
      {
        image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
        name: 'simple-hello-world-container'
        probes: [
          {
            httpGet: {
              httpHeaders: [
                {
                  name: 'Custom-Header'
                  value: 'Awesome'
                }
              ]
              path: '/health'
              port: 8080
            }
            initialDelaySeconds: 3
            periodSeconds: 3
            type: 'Liveness'
          }
        ]
        resources: {
          cpu: '<cpu>'
          memory: '0.5Gi'
        }
      }
    ]
    environmentResourceId: '<environmentResourceId>'
    name: 'acawaf001'
    // Non-required parameters
    diagnosticSettings: [
      {
        eventHubAuthorizationRuleResourceId: '<eventHubAuthorizationRuleResourceId>'
        eventHubName: '<eventHubName>'
        logCategoriesAndGroups: []
        metricCategories: [
          {
            category: 'AllMetrics'
          }
        ]
        storageAccountResourceId: '<storageAccountResourceId>'
        workspaceResourceId: '<workspaceResourceId>'
      }
    ]
    ingressAllowInsecure: false
    ingressExternal: false
    managedIdentities: {
      userAssignedResourceIds: [
        '<managedIdentityResourceId>'
      ]
    }
    tags: {
      Env: 'test'
      'hidden-title': 'This is visible in the resource name'
    }
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "containers": {
      "value": [
        {
          "image": "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest",
          "name": "simple-hello-world-container",
          "probes": [
            {
              "httpGet": {
                "httpHeaders": [
                  {
                    "name": "Custom-Header",
                    "value": "Awesome"
                  }
                ],
                "path": "/health",
                "port": 8080
              },
              "initialDelaySeconds": 3,
              "periodSeconds": 3,
              "type": "Liveness"
            }
          ],
          "resources": {
            "cpu": "<cpu>",
            "memory": "0.5Gi"
          }
        }
      ]
    },
    "environmentResourceId": {
      "value": "<environmentResourceId>"
    },
    "name": {
      "value": "acawaf001"
    },
    // Non-required parameters
    "diagnosticSettings": {
      "value": [
        {
          "eventHubAuthorizationRuleResourceId": "<eventHubAuthorizationRuleResourceId>",
          "eventHubName": "<eventHubName>",
          "logCategoriesAndGroups": [],
          "metricCategories": [
            {
              "category": "AllMetrics"
            }
          ],
          "storageAccountResourceId": "<storageAccountResourceId>",
          "workspaceResourceId": "<workspaceResourceId>"
        }
      ]
    },
    "ingressAllowInsecure": {
      "value": false
    },
    "ingressExternal": {
      "value": false
    },
    "managedIdentities": {
      "value": {
        "userAssignedResourceIds": [
          "<managedIdentityResourceId>"
        ]
      }
    },
    "tags": {
      "value": {
        "Env": "test",
        "hidden-title": "This is visible in the resource name"
      }
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/app/container-app:<version>'

// Required parameters
param containers = [
  {
    image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
    name: 'simple-hello-world-container'
    probes: [
      {
        httpGet: {
          httpHeaders: [
            {
              name: 'Custom-Header'
              value: 'Awesome'
            }
          ]
          path: '/health'
          port: 8080
        }
        initialDelaySeconds: 3
        periodSeconds: 3
        type: 'Liveness'
      }
    ]
    resources: {
      cpu: '<cpu>'
      memory: '0.5Gi'
    }
  }
]
param environmentResourceId = '<environmentResourceId>'
param name = 'acawaf001'
// Non-required parameters
param diagnosticSettings = [
  {
    eventHubAuthorizationRuleResourceId: '<eventHubAuthorizationRuleResourceId>'
    eventHubName: '<eventHubName>'
    logCategoriesAndGroups: []
    metricCategories: [
      {
        category: 'AllMetrics'
      }
    ]
    storageAccountResourceId: '<storageAccountResourceId>'
    workspaceResourceId: '<workspaceResourceId>'
  }
]
param ingressAllowInsecure = false
param ingressExternal = false
param managedIdentities = {
  userAssignedResourceIds: [
    '<managedIdentityResourceId>'
  ]
}
param tags = {
  Env: 'test'
  'hidden-title': 'This is visible in the resource name'
}
```

</details>
<p>

## Parameters

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`containers`](#parameter-containers) | array | List of container definitions for the Container App. |
| [`environmentResourceId`](#parameter-environmentresourceid) | string | Resource ID of environment. |
| [`name`](#parameter-name) | string | Name of the Container App. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`activeRevisionsMode`](#parameter-activerevisionsmode) | string | Controls how active revisions are handled for the Container app. |
| [`additionalPortMappings`](#parameter-additionalportmappings) | array | Settings to expose additional ports on container app. |
| [`authConfig`](#parameter-authconfig) | object | The name of the Container App Auth configs. |
| [`clientCertificateMode`](#parameter-clientcertificatemode) | string | Client certificate mode for mTLS. |
| [`corsPolicy`](#parameter-corspolicy) | object | Object userd to configure CORS policy. |
| [`customDomains`](#parameter-customdomains) | array | Custom domain bindings for Container App hostnames. |
| [`dapr`](#parameter-dapr) | object | Dapr configuration for the Container App. |
| [`diagnosticSettings`](#parameter-diagnosticsettings) | array | The diagnostic settings of the service. |
| [`disableIngress`](#parameter-disableingress) | bool | Bool to disable all ingress traffic for the container app. |
| [`enableTelemetry`](#parameter-enabletelemetry) | bool | Enable/Disable usage telemetry for module. |
| [`exposedPort`](#parameter-exposedport) | int | Exposed Port in containers for TCP traffic from ingress. |
| [`identitySettings`](#parameter-identitysettings) | array | Settings for Managed Identities that are assigned to the Container App. If a Managed Identity is not specified here, default settings will be used. |
| [`includeAddOns`](#parameter-includeaddons) | bool | Toggle to include the service configuration. |
| [`ingressAllowInsecure`](#parameter-ingressallowinsecure) | bool | Bool indicating if HTTP connections to is allowed. If set to false HTTP connections are automatically redirected to HTTPS connections. |
| [`ingressExternal`](#parameter-ingressexternal) | bool | Bool indicating if the App exposes an external HTTP endpoint. |
| [`ingressTargetPort`](#parameter-ingresstargetport) | int | Target Port in containers for traffic from ingress. |
| [`ingressTransport`](#parameter-ingresstransport) | string | Ingress transport protocol. |
| [`initContainersTemplate`](#parameter-initcontainerstemplate) | array | List of specialized containers that run before app containers. |
| [`ipSecurityRestrictions`](#parameter-ipsecurityrestrictions) | array | Rules to restrict incoming IP address. |
| [`location`](#parameter-location) | string | Location for all Resources. |
| [`lock`](#parameter-lock) | object | The lock settings of the service. |
| [`managedIdentities`](#parameter-managedidentities) | object | The managed identity definition for this resource. |
| [`maxInactiveRevisions`](#parameter-maxinactiverevisions) | int | Max inactive revisions a Container App can have. |
| [`registries`](#parameter-registries) | array | Collection of private container registry credentials for containers used by the Container app. |
| [`revisionSuffix`](#parameter-revisionsuffix) | string | User friendly suffix that is appended to the revision name. |
| [`roleAssignments`](#parameter-roleassignments) | array | Array of role assignments to create. |
| [`runtime`](#parameter-runtime) | object | Runtime configuration for the Container App. |
| [`scaleSettings`](#parameter-scalesettings) | object | The scaling settings of the service. |
| [`secrets`](#parameter-secrets) | array | The secrets of the Container App. |
| [`service`](#parameter-service) | object | Dev ContainerApp service type. |
| [`serviceBinds`](#parameter-servicebinds) | array | List of container app services bound to the app. |
| [`stickySessionsAffinity`](#parameter-stickysessionsaffinity) | string | Bool indicating if the Container App should enable session affinity. |
| [`tags`](#parameter-tags) | object | Tags of the resource. |
| [`trafficLabel`](#parameter-trafficlabel) | string | Associates a traffic label with a revision. Label name should be consist of lower case alphanumeric characters or dashes. |
| [`trafficLatestRevision`](#parameter-trafficlatestrevision) | bool | Indicates that the traffic weight belongs to a latest stable revision. |
| [`trafficRevisionName`](#parameter-trafficrevisionname) | string | Name of a revision. |
| [`trafficWeight`](#parameter-trafficweight) | int | Traffic weight assigned to a revision. |
| [`volumes`](#parameter-volumes) | array | List of volume definitions for the Container App. |
| [`workloadProfileName`](#parameter-workloadprofilename) | string | Workload profile name to pin for container app execution. |

### Parameter: `containers`

List of container definitions for the Container App.

- Required: Yes
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`image`](#parameter-containersimage) | string | Container image tag. |
| [`resources`](#parameter-containersresources) | object | Container resource requirements. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`args`](#parameter-containersargs) | array | Container start command arguments. |
| [`command`](#parameter-containerscommand) | array | Container start command. |
| [`env`](#parameter-containersenv) | array | Container environment variables. |
| [`name`](#parameter-containersname) | string | Custom container name. |
| [`probes`](#parameter-containersprobes) | array | List of probes for the container. |
| [`volumeMounts`](#parameter-containersvolumemounts) | array | Container volume mounts. |

### Parameter: `containers.image`

Container image tag.

- Required: Yes
- Type: string

### Parameter: `containers.resources`

Container resource requirements.

- Required: Yes
- Type: object

### Parameter: `containers.args`

Container start command arguments.

- Required: No
- Type: array

### Parameter: `containers.command`

Container start command.

- Required: No
- Type: array

### Parameter: `containers.env`

Container environment variables.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-containersenvname) | string | Environment variable name. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`secretRef`](#parameter-containersenvsecretref) | string | Name of the Container App secret from which to pull the environment variable value. |
| [`value`](#parameter-containersenvvalue) | string | Non-secret environment variable value. |

### Parameter: `containers.env.name`

Environment variable name.

- Required: Yes
- Type: string

### Parameter: `containers.env.secretRef`

Name of the Container App secret from which to pull the environment variable value.

- Required: No
- Type: string

### Parameter: `containers.env.value`

Non-secret environment variable value.

- Required: No
- Type: string

### Parameter: `containers.name`

Custom container name.

- Required: No
- Type: string

### Parameter: `containers.probes`

List of probes for the container.

- Required: No
- Type: array

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`failureThreshold`](#parameter-containersprobesfailurethreshold) | int | Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. |
| [`httpGet`](#parameter-containersprobeshttpget) | object | HTTPGet specifies the http request to perform. |
| [`initialDelaySeconds`](#parameter-containersprobesinitialdelayseconds) | int | Number of seconds after the container has started before liveness probes are initiated. |
| [`periodSeconds`](#parameter-containersprobesperiodseconds) | int | How often (in seconds) to perform the probe. Default to 10 seconds. |
| [`successThreshold`](#parameter-containersprobessuccessthreshold) | int | Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. |
| [`tcpSocket`](#parameter-containersprobestcpsocket) | object | The TCP socket specifies an action involving a TCP port. TCP hooks not yet supported. |
| [`terminationGracePeriodSeconds`](#parameter-containersprobesterminationgraceperiodseconds) | int | Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is an alpha field and requires enabling ProbeTerminationGracePeriod feature gate. Maximum value is 3600 seconds (1 hour). |
| [`timeoutSeconds`](#parameter-containersprobestimeoutseconds) | int | Number of seconds after which the probe times out. Defaults to 1 second. |
| [`type`](#parameter-containersprobestype) | string | The type of probe. |

### Parameter: `containers.probes.failureThreshold`

Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3.

- Required: No
- Type: int
- MinValue: 1
- MaxValue: 10

### Parameter: `containers.probes.httpGet`

HTTPGet specifies the http request to perform.

- Required: No
- Type: object

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`path`](#parameter-containersprobeshttpgetpath) | string | Path to access on the HTTP server. |
| [`port`](#parameter-containersprobeshttpgetport) | int | Name or number of the port to access on the container. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`host`](#parameter-containersprobeshttpgethost) | string | Host name to connect to. Defaults to the pod IP. |
| [`httpHeaders`](#parameter-containersprobeshttpgethttpheaders) | array | HTTP headers to set in the request. |
| [`scheme`](#parameter-containersprobeshttpgetscheme) | string | Scheme to use for connecting to the host. Defaults to HTTP. |

### Parameter: `containers.probes.httpGet.path`

Path to access on the HTTP server.

- Required: Yes
- Type: string

### Parameter: `containers.probes.httpGet.port`

Name or number of the port to access on the container.

- Required: Yes
- Type: int

### Parameter: `containers.probes.httpGet.host`

Host name to connect to. Defaults to the pod IP.

- Required: No
- Type: string

### Parameter: `containers.probes.httpGet.httpHeaders`

HTTP headers to set in the request.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-containersprobeshttpgethttpheadersname) | string | Name of the header. |
| [`value`](#parameter-containersprobeshttpgethttpheadersvalue) | string | Value of the header. |

### Parameter: `containers.probes.httpGet.httpHeaders.name`

Name of the header.

- Required: Yes
- Type: string

### Parameter: `containers.probes.httpGet.httpHeaders.value`

Value of the header.

- Required: Yes
- Type: string

### Parameter: `containers.probes.httpGet.scheme`

Scheme to use for connecting to the host. Defaults to HTTP.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'HTTP'
    'HTTPS'
  ]
  ```

### Parameter: `containers.probes.initialDelaySeconds`

Number of seconds after the container has started before liveness probes are initiated.

- Required: No
- Type: int
- MinValue: 1
- MaxValue: 60

### Parameter: `containers.probes.periodSeconds`

How often (in seconds) to perform the probe. Default to 10 seconds.

- Required: No
- Type: int
- MinValue: 1
- MaxValue: 240

### Parameter: `containers.probes.successThreshold`

Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup.

- Required: No
- Type: int
- MinValue: 1
- MaxValue: 10

### Parameter: `containers.probes.tcpSocket`

The TCP socket specifies an action involving a TCP port. TCP hooks not yet supported.

- Required: No
- Type: object

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`port`](#parameter-containersprobestcpsocketport) | int | Number of the port to access on the container. Name must be an IANA_SVC_NAME. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`host`](#parameter-containersprobestcpsockethost) | string | Host name to connect to, defaults to the pod IP. |

### Parameter: `containers.probes.tcpSocket.port`

Number of the port to access on the container. Name must be an IANA_SVC_NAME.

- Required: Yes
- Type: int
- MinValue: 1
- MaxValue: 65535

### Parameter: `containers.probes.tcpSocket.host`

Host name to connect to, defaults to the pod IP.

- Required: No
- Type: string

### Parameter: `containers.probes.terminationGracePeriodSeconds`

Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is an alpha field and requires enabling ProbeTerminationGracePeriod feature gate. Maximum value is 3600 seconds (1 hour).

- Required: No
- Type: int

### Parameter: `containers.probes.timeoutSeconds`

Number of seconds after which the probe times out. Defaults to 1 second.

- Required: No
- Type: int
- MinValue: 1
- MaxValue: 240

### Parameter: `containers.probes.type`

The type of probe.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'Liveness'
    'Readiness'
    'Startup'
  ]
  ```

### Parameter: `containers.volumeMounts`

Container volume mounts.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`mountPath`](#parameter-containersvolumemountsmountpath) | string | Path within the container at which the volume should be mounted.Must not contain ':'. |
| [`volumeName`](#parameter-containersvolumemountsvolumename) | string | This must match the Name of a Volume. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`subPath`](#parameter-containersvolumemountssubpath) | string | Path within the volume from which the container's volume should be mounted. Defaults to "" (volume's root). |

### Parameter: `containers.volumeMounts.mountPath`

Path within the container at which the volume should be mounted.Must not contain ':'.

- Required: Yes
- Type: string

### Parameter: `containers.volumeMounts.volumeName`

This must match the Name of a Volume.

- Required: Yes
- Type: string

### Parameter: `containers.volumeMounts.subPath`

Path within the volume from which the container's volume should be mounted. Defaults to "" (volume's root).

- Required: No
- Type: string

### Parameter: `environmentResourceId`

Resource ID of environment.

- Required: Yes
- Type: string

### Parameter: `name`

Name of the Container App.

- Required: Yes
- Type: string

### Parameter: `activeRevisionsMode`

Controls how active revisions are handled for the Container app.

- Required: No
- Type: string
- Default: `'Single'`
- Allowed:
  ```Bicep
  [
    'Multiple'
    'Single'
  ]
  ```

### Parameter: `additionalPortMappings`

Settings to expose additional ports on container app.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`external`](#parameter-additionalportmappingsexternal) | bool | Specifies whether the app port is accessible outside of the environment. |
| [`targetPort`](#parameter-additionalportmappingstargetport) | int | Specifies the port the container listens on. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`exposedPort`](#parameter-additionalportmappingsexposedport) | int | Specifies the exposed port for the target port. If not specified, it defaults to target port. |

### Parameter: `additionalPortMappings.external`

Specifies whether the app port is accessible outside of the environment.

- Required: Yes
- Type: bool

### Parameter: `additionalPortMappings.targetPort`

Specifies the port the container listens on.

- Required: Yes
- Type: int

### Parameter: `additionalPortMappings.exposedPort`

Specifies the exposed port for the target port. If not specified, it defaults to target port.

- Required: No
- Type: int

### Parameter: `authConfig`

The name of the Container App Auth configs.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`encryptionSettings`](#parameter-authconfigencryptionsettings) | object | The configuration settings of the secrets references of encryption key and signing key for ContainerApp Service Authentication/Authorization. |
| [`globalValidation`](#parameter-authconfigglobalvalidation) | object | The configuration settings that determines the validation flow of users using Service Authentication and/or Authorization. |
| [`httpSettings`](#parameter-authconfighttpsettings) | object | The configuration settings of the HTTP requests for authentication and authorization requests made against ContainerApp Service Authentication/Authorization. |
| [`identityProviders`](#parameter-authconfigidentityproviders) | object | The configuration settings of each of the identity providers used to configure ContainerApp Service Authentication/Authorization. |
| [`login`](#parameter-authconfiglogin) | object | The configuration settings of the login flow of users using ContainerApp Service Authentication/Authorization. |
| [`platform`](#parameter-authconfigplatform) | object | The configuration settings of the platform of ContainerApp Service Authentication/Authorization. |

### Parameter: `authConfig.encryptionSettings`

The configuration settings of the secrets references of encryption key and signing key for ContainerApp Service Authentication/Authorization.

- Required: No
- Type: object

### Parameter: `authConfig.globalValidation`

The configuration settings that determines the validation flow of users using Service Authentication and/or Authorization.

- Required: No
- Type: object

### Parameter: `authConfig.httpSettings`

The configuration settings of the HTTP requests for authentication and authorization requests made against ContainerApp Service Authentication/Authorization.

- Required: No
- Type: object

### Parameter: `authConfig.identityProviders`

The configuration settings of each of the identity providers used to configure ContainerApp Service Authentication/Authorization.

- Required: No
- Type: object

### Parameter: `authConfig.login`

The configuration settings of the login flow of users using ContainerApp Service Authentication/Authorization.

- Required: No
- Type: object

### Parameter: `authConfig.platform`

The configuration settings of the platform of ContainerApp Service Authentication/Authorization.

- Required: No
- Type: object

### Parameter: `clientCertificateMode`

Client certificate mode for mTLS.

- Required: No
- Type: string
- Default: `'ignore'`
- Allowed:
  ```Bicep
  [
    'accept'
    'ignore'
    'require'
  ]
  ```

### Parameter: `corsPolicy`

Object userd to configure CORS policy.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`allowCredentials`](#parameter-corspolicyallowcredentials) | bool | Switch to determine whether the resource allows credentials. |
| [`allowedHeaders`](#parameter-corspolicyallowedheaders) | array | Specifies the content for the access-control-allow-headers header. |
| [`allowedMethods`](#parameter-corspolicyallowedmethods) | array | Specifies the content for the access-control-allow-methods header. |
| [`allowedOrigins`](#parameter-corspolicyallowedorigins) | array | Specifies the content for the access-control-allow-origins header. |
| [`exposeHeaders`](#parameter-corspolicyexposeheaders) | array | Specifies the content for the access-control-expose-headers header. |
| [`maxAge`](#parameter-corspolicymaxage) | int | Specifies the content for the access-control-max-age header. |

### Parameter: `corsPolicy.allowCredentials`

Switch to determine whether the resource allows credentials.

- Required: No
- Type: bool

### Parameter: `corsPolicy.allowedHeaders`

Specifies the content for the access-control-allow-headers header.

- Required: No
- Type: array

### Parameter: `corsPolicy.allowedMethods`

Specifies the content for the access-control-allow-methods header.

- Required: No
- Type: array

### Parameter: `corsPolicy.allowedOrigins`

Specifies the content for the access-control-allow-origins header.

- Required: No
- Type: array

### Parameter: `corsPolicy.exposeHeaders`

Specifies the content for the access-control-expose-headers header.

- Required: No
- Type: array

### Parameter: `corsPolicy.maxAge`

Specifies the content for the access-control-max-age header.

- Required: No
- Type: int

### Parameter: `customDomains`

Custom domain bindings for Container App hostnames.

- Required: No
- Type: array

### Parameter: `dapr`

Dapr configuration for the Container App.

- Required: No
- Type: object

### Parameter: `diagnosticSettings`

The diagnostic settings of the service.

- Required: No
- Type: array

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`eventHubAuthorizationRuleResourceId`](#parameter-diagnosticsettingseventhubauthorizationruleresourceid) | string | Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to. |
| [`eventHubName`](#parameter-diagnosticsettingseventhubname) | string | Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub. |
| [`logAnalyticsDestinationType`](#parameter-diagnosticsettingsloganalyticsdestinationtype) | string | A string indicating whether the export to Log Analytics should use the default destination type, i.e. AzureDiagnostics, or use a destination type. |
| [`marketplacePartnerResourceId`](#parameter-diagnosticsettingsmarketplacepartnerresourceid) | string | The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic Logs. |
| [`metricCategories`](#parameter-diagnosticsettingsmetriccategories) | array | The name of metrics that will be streamed. "allMetrics" includes all possible metrics for the resource. Set to `[]` to disable metric collection. |
| [`name`](#parameter-diagnosticsettingsname) | string | The name of diagnostic setting. |
| [`storageAccountResourceId`](#parameter-diagnosticsettingsstorageaccountresourceid) | string | Resource ID of the diagnostic storage account. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub. |
| [`workspaceResourceId`](#parameter-diagnosticsettingsworkspaceresourceid) | string | Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub. |

### Parameter: `diagnosticSettings.eventHubAuthorizationRuleResourceId`

Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.eventHubName`

Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.logAnalyticsDestinationType`

A string indicating whether the export to Log Analytics should use the default destination type, i.e. AzureDiagnostics, or use a destination type.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'AzureDiagnostics'
    'Dedicated'
  ]
  ```

### Parameter: `diagnosticSettings.marketplacePartnerResourceId`

The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic Logs.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.metricCategories`

The name of metrics that will be streamed. "allMetrics" includes all possible metrics for the resource. Set to `[]` to disable metric collection.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`category`](#parameter-diagnosticsettingsmetriccategoriescategory) | string | Name of a Diagnostic Metric category for a resource type this setting is applied to. Set to `AllMetrics` to collect all metrics. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`enabled`](#parameter-diagnosticsettingsmetriccategoriesenabled) | bool | Enable or disable the category explicitly. Default is `true`. |

### Parameter: `diagnosticSettings.metricCategories.category`

Name of a Diagnostic Metric category for a resource type this setting is applied to. Set to `AllMetrics` to collect all metrics.

- Required: Yes
- Type: string

### Parameter: `diagnosticSettings.metricCategories.enabled`

Enable or disable the category explicitly. Default is `true`.

- Required: No
- Type: bool

### Parameter: `diagnosticSettings.name`

The name of diagnostic setting.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.storageAccountResourceId`

Resource ID of the diagnostic storage account. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.workspaceResourceId`

Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.

- Required: No
- Type: string

### Parameter: `disableIngress`

Bool to disable all ingress traffic for the container app.

- Required: No
- Type: bool
- Default: `False`

### Parameter: `enableTelemetry`

Enable/Disable usage telemetry for module.

- Required: No
- Type: bool
- Default: `True`

### Parameter: `exposedPort`

Exposed Port in containers for TCP traffic from ingress.

- Required: No
- Type: int
- Default: `0`

### Parameter: `identitySettings`

Settings for Managed Identities that are assigned to the Container App. If a Managed Identity is not specified here, default settings will be used.

- Required: No
- Type: array

### Parameter: `includeAddOns`

Toggle to include the service configuration.

- Required: No
- Type: bool
- Default: `False`

### Parameter: `ingressAllowInsecure`

Bool indicating if HTTP connections to is allowed. If set to false HTTP connections are automatically redirected to HTTPS connections.

- Required: No
- Type: bool
- Default: `True`

### Parameter: `ingressExternal`

Bool indicating if the App exposes an external HTTP endpoint.

- Required: No
- Type: bool
- Default: `True`

### Parameter: `ingressTargetPort`

Target Port in containers for traffic from ingress.

- Required: No
- Type: int
- Default: `80`

### Parameter: `ingressTransport`

Ingress transport protocol.

- Required: No
- Type: string
- Default: `'auto'`
- Allowed:
  ```Bicep
  [
    'auto'
    'http'
    'http2'
    'tcp'
  ]
  ```

### Parameter: `initContainersTemplate`

List of specialized containers that run before app containers.

- Required: No
- Type: array

### Parameter: `ipSecurityRestrictions`

Rules to restrict incoming IP address.

- Required: No
- Type: array

### Parameter: `location`

Location for all Resources.

- Required: No
- Type: string
- Default: `[resourceGroup().location]`

### Parameter: `lock`

The lock settings of the service.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`kind`](#parameter-lockkind) | string | Specify the type of lock. |
| [`name`](#parameter-lockname) | string | Specify the name of lock. |

### Parameter: `lock.kind`

Specify the type of lock.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'CanNotDelete'
    'None'
    'ReadOnly'
  ]
  ```

### Parameter: `lock.name`

Specify the name of lock.

- Required: No
- Type: string

### Parameter: `managedIdentities`

The managed identity definition for this resource.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`systemAssigned`](#parameter-managedidentitiessystemassigned) | bool | Enables system assigned managed identity on the resource. |
| [`userAssignedResourceIds`](#parameter-managedidentitiesuserassignedresourceids) | array | The resource ID(s) to assign to the resource. Required if a user assigned identity is used for encryption. |

### Parameter: `managedIdentities.systemAssigned`

Enables system assigned managed identity on the resource.

- Required: No
- Type: bool

### Parameter: `managedIdentities.userAssignedResourceIds`

The resource ID(s) to assign to the resource. Required if a user assigned identity is used for encryption.

- Required: No
- Type: array

### Parameter: `maxInactiveRevisions`

Max inactive revisions a Container App can have.

- Required: No
- Type: int
- Default: `0`

### Parameter: `registries`

Collection of private container registry credentials for containers used by the Container app.

- Required: No
- Type: array

### Parameter: `revisionSuffix`

User friendly suffix that is appended to the revision name.

- Required: No
- Type: string
- Default: `''`

### Parameter: `roleAssignments`

Array of role assignments to create.

- Required: No
- Type: array
- Roles configurable by name:
  - `'ContainerApp Reader'`
  - `'Contributor'`
  - `'Owner'`
  - `'Reader'`
  - `'Role Based Access Control Administrator'`
  - `'User Access Administrator'`

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`principalId`](#parameter-roleassignmentsprincipalid) | string | The principal ID of the principal (user/group/identity) to assign the role to. |
| [`roleDefinitionIdOrName`](#parameter-roleassignmentsroledefinitionidorname) | string | The role to assign. You can provide either the display name of the role definition, the role definition GUID, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`condition`](#parameter-roleassignmentscondition) | string | The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container". |
| [`conditionVersion`](#parameter-roleassignmentsconditionversion) | string | Version of the condition. |
| [`delegatedManagedIdentityResourceId`](#parameter-roleassignmentsdelegatedmanagedidentityresourceid) | string | The Resource Id of the delegated managed identity resource. |
| [`description`](#parameter-roleassignmentsdescription) | string | The description of the role assignment. |
| [`name`](#parameter-roleassignmentsname) | string | The name (as GUID) of the role assignment. If not provided, a GUID will be generated. |
| [`principalType`](#parameter-roleassignmentsprincipaltype) | string | The principal type of the assigned principal ID. |

### Parameter: `roleAssignments.principalId`

The principal ID of the principal (user/group/identity) to assign the role to.

- Required: Yes
- Type: string

### Parameter: `roleAssignments.roleDefinitionIdOrName`

The role to assign. You can provide either the display name of the role definition, the role definition GUID, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.

- Required: Yes
- Type: string

### Parameter: `roleAssignments.condition`

The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container".

- Required: No
- Type: string

### Parameter: `roleAssignments.conditionVersion`

Version of the condition.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    '2.0'
  ]
  ```

### Parameter: `roleAssignments.delegatedManagedIdentityResourceId`

The Resource Id of the delegated managed identity resource.

- Required: No
- Type: string

### Parameter: `roleAssignments.description`

The description of the role assignment.

- Required: No
- Type: string

### Parameter: `roleAssignments.name`

The name (as GUID) of the role assignment. If not provided, a GUID will be generated.

- Required: No
- Type: string

### Parameter: `roleAssignments.principalType`

The principal type of the assigned principal ID.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'Device'
    'ForeignGroup'
    'Group'
    'ServicePrincipal'
    'User'
  ]
  ```

### Parameter: `runtime`

Runtime configuration for the Container App.

- Required: No
- Type: object

### Parameter: `scaleSettings`

The scaling settings of the service.

- Required: No
- Type: object
- Default:
  ```Bicep
  {
      maxReplicas: 10
      minReplicas: 3
  }
  ```

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`maxReplicas`](#parameter-scalesettingsmaxreplicas) | int | The maximum number of replicas. |
| [`minReplicas`](#parameter-scalesettingsminreplicas) | int | The minimum number of replicas. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`cooldownPeriod`](#parameter-scalesettingscooldownperiod) | int | The cooldown period in seconds. |
| [`pollingInterval`](#parameter-scalesettingspollinginterval) | int | The polling interval in seconds. |
| [`rules`](#parameter-scalesettingsrules) | array | The scaling rules. |

### Parameter: `scaleSettings.maxReplicas`

The maximum number of replicas.

- Required: Yes
- Type: int

### Parameter: `scaleSettings.minReplicas`

The minimum number of replicas.

- Required: Yes
- Type: int

### Parameter: `scaleSettings.cooldownPeriod`

The cooldown period in seconds.

- Required: No
- Type: int

### Parameter: `scaleSettings.pollingInterval`

The polling interval in seconds.

- Required: No
- Type: int

### Parameter: `scaleSettings.rules`

The scaling rules.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-scalesettingsrulesname) | string | The name of the scaling rule. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`azureQueue`](#parameter-scalesettingsrulesazurequeue) | object | The Azure Queue based scaling rule. |
| [`custom`](#parameter-scalesettingsrulescustom) | object | The custom scaling rule. |
| [`http`](#parameter-scalesettingsruleshttp) | object | The HTTP requests based scaling rule. |
| [`tcp`](#parameter-scalesettingsrulestcp) | object | The TCP based scaling rule. |

### Parameter: `scaleSettings.rules.name`

The name of the scaling rule.

- Required: Yes
- Type: string

### Parameter: `scaleSettings.rules.azureQueue`

The Azure Queue based scaling rule.

- Required: No
- Type: object

### Parameter: `scaleSettings.rules.custom`

The custom scaling rule.

- Required: No
- Type: object

### Parameter: `scaleSettings.rules.http`

The HTTP requests based scaling rule.

- Required: No
- Type: object

### Parameter: `scaleSettings.rules.tcp`

The TCP based scaling rule.

- Required: No
- Type: object

### Parameter: `secrets`

The secrets of the Container App.

- Required: No
- Type: array

**Conditional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`keyVaultUrl`](#parameter-secretskeyvaulturl) | string | The URL of the Azure Key Vault secret referenced by the Container App. Required if `value` is null. |
| [`value`](#parameter-secretsvalue) | securestring | The container app secret value, if not fetched from the Key Vault. Required if `keyVaultUrl` is not null. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`identity`](#parameter-secretsidentity) | string | Resource ID of a managed identity to authenticate with Azure Key Vault, or System to use a system-assigned identity. |
| [`name`](#parameter-secretsname) | string | The name of the container app secret. |

### Parameter: `secrets.keyVaultUrl`

The URL of the Azure Key Vault secret referenced by the Container App. Required if `value` is null.

- Required: No
- Type: string

### Parameter: `secrets.value`

The container app secret value, if not fetched from the Key Vault. Required if `keyVaultUrl` is not null.

- Required: No
- Type: securestring

### Parameter: `secrets.identity`

Resource ID of a managed identity to authenticate with Azure Key Vault, or System to use a system-assigned identity.

- Required: No
- Type: string

### Parameter: `secrets.name`

The name of the container app secret.

- Required: No
- Type: string

### Parameter: `service`

Dev ContainerApp service type.

- Required: No
- Type: object

### Parameter: `serviceBinds`

List of container app services bound to the app.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-servicebindsname) | string | The name of the service. |
| [`serviceId`](#parameter-servicebindsserviceid) | string | The service ID. |

### Parameter: `serviceBinds.name`

The name of the service.

- Required: Yes
- Type: string

### Parameter: `serviceBinds.serviceId`

The service ID.

- Required: Yes
- Type: string

### Parameter: `stickySessionsAffinity`

Bool indicating if the Container App should enable session affinity.

- Required: No
- Type: string
- Default: `'none'`
- Allowed:
  ```Bicep
  [
    'none'
    'sticky'
  ]
  ```

### Parameter: `tags`

Tags of the resource.

- Required: No
- Type: object

### Parameter: `trafficLabel`

Associates a traffic label with a revision. Label name should be consist of lower case alphanumeric characters or dashes.

- Required: No
- Type: string
- Default: `'label-1'`

### Parameter: `trafficLatestRevision`

Indicates that the traffic weight belongs to a latest stable revision.

- Required: No
- Type: bool
- Default: `True`

### Parameter: `trafficRevisionName`

Name of a revision.

- Required: No
- Type: string
- Default: `''`

### Parameter: `trafficWeight`

Traffic weight assigned to a revision.

- Required: No
- Type: int
- Default: `100`

### Parameter: `volumes`

List of volume definitions for the Container App.

- Required: No
- Type: array

### Parameter: `workloadProfileName`

Workload profile name to pin for container app execution.

- Required: No
- Type: string
- Default: `''`

## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `fqdn` | string | The configuration of ingress fqdn. |
| `location` | string | The location the resource was deployed into. |
| `name` | string | The name of the Container App. |
| `resourceGroupName` | string | The name of the resource group the Container App was deployed into. |
| `resourceId` | string | The resource ID of the Container App. |
| `systemAssignedMIPrincipalId` | string | The principal ID of the system assigned identity. |

## Cross-referenced modules

This section gives you an overview of all local-referenced module files (i.e., other modules that are referenced in this module) and all remote-referenced files (i.e., Bicep modules that are referenced from a Bicep Registry or Template Specs).

| Reference | Type |
| :-- | :-- |
| `br/public:avm/utl/types/avm-common-types:0.4.1` | Remote reference |
| `br/public:avm/utl/types/avm-common-types:0.6.0` | Remote reference |

## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the [repository](https://aka.ms/avm/telemetry). There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
