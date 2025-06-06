# Site Deployment Extension  `[Microsoft.Web/sites/slots/extensions]`

This module deploys a Site extension for MSDeploy.

## Navigation

- [Resource Types](#Resource-Types)
- [Parameters](#Parameters)
- [Outputs](#Outputs)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.Web/sites/slots/extensions` | [2024-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Web/2024-04-01/sites/slots/extensions) |

## Parameters

**Conditional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`appName`](#parameter-appname) | string | The name of the parent site resource. Required if the template is used in a standalone deployment. |
| [`slotName`](#parameter-slotname) | string | The name of the parent web site slot. Required if the template is used in a standalone deployment. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`kind`](#parameter-kind) | string | The kind of extension. |
| [`name`](#parameter-name) | string | The name of the extension. |
| [`properties`](#parameter-properties) | object | Sets the properties. |

### Parameter: `appName`

The name of the parent site resource. Required if the template is used in a standalone deployment.

- Required: Yes
- Type: string

### Parameter: `slotName`

The name of the parent web site slot. Required if the template is used in a standalone deployment.

- Required: Yes
- Type: string

### Parameter: `kind`

The kind of extension.

- Required: No
- Type: string
- Default: `'MSDeploy'`
- Allowed:
  ```Bicep
  [
    'MSDeploy'
  ]
  ```

### Parameter: `name`

The name of the extension.

- Required: No
- Type: string
- Default: `'MSDeploy'`
- Allowed:
  ```Bicep
  [
    'MSDeploy'
  ]
  ```

### Parameter: `properties`

Sets the properties.

- Required: No
- Type: object

## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `name` | string | The name of the extension. |
| `resourceGroupName` | string | The resource group the extensino was deployed into. |
| `resourceId` | string | The resource ID of the extension. |
