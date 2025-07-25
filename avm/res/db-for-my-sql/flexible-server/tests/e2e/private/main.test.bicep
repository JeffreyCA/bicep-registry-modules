targetScope = 'subscription'

metadata name = 'Deploys in connectivity mode "Private Access"'
metadata description = 'This instance deploys the module with connectivity mode "Private Access".'

// ========== //
// Parameters //
// ========== //

@description('Optional. The name of the resource group to deploy for testing purposes.')
@maxLength(90)
param resourceGroupName string = 'dep-${namePrefix}-dbformysql.flexibleservers-${serviceShort}-rg'

@description('Optional. A short identifier for the kind of deployment. Should be kept short to not run into resource-name length-constraints.')
param serviceShort string = 'dfmspvt'

@description('Optional. The password to leverage for the login.')
@secure()
param password string = newGuid()

@description('Optional. A token to inject into the name of each resource.')
param namePrefix string = '#_namePrefix_#'

// Pipeline is selecting random regions which dont support all cosmos features and have constraints when creating new cosmos
#disable-next-line no-hardcoded-location
var enforcedLocation = 'northeurope'

// ============ //
// Dependencies //
// ============ //

// General resources
// =================
resource resourceGroup 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: enforcedLocation
}

module nestedDependencies 'dependencies.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, enforcedLocation)}-nestedDependencies'
  params: {
    virtualNetworkName: 'dep-${namePrefix}-vnet-${serviceShort}'
    managedIdentityName: 'dep-${namePrefix}-msi-${serviceShort}'
    networkSecurityGroupName: 'dep-${namePrefix}-nsg-${serviceShort}'
  }
}

// ============== //
// Test Execution //
// ============== //

@batchSize(1)
module testDeployment '../../../main.bicep' = [
  for iteration in ['init', 'idem']: {
    scope: resourceGroup
    name: '${uniqueString(deployment().name, enforcedLocation)}-test-${serviceShort}-${iteration}'
    params: {
      name: '${namePrefix}${serviceShort}001'
      administratorLogin: 'adminUserName'
      administratorLoginPassword: password
      skuName: 'Standard_D2ds_v4'
      tier: 'GeneralPurpose'
      availabilityZone: -1
      delegatedSubnetResourceId: nestedDependencies.outputs.subnetResourceId
      privateDnsZoneResourceId: nestedDependencies.outputs.privateDNSZoneResourceId
      firewallRules: [
        {
          endIpAddress: '0.0.0.0'
          name: 'AllowAllWindowsAzureIps'
          startIpAddress: '0.0.0.0'
        }
        {
          endIpAddress: '10.10.10.10'
          name: 'test-rule1'
          startIpAddress: '10.10.10.1'
        }
        {
          endIpAddress: '100.100.100.10'
          name: 'test-rule2'
          startIpAddress: '100.100.100.1'
        }
      ]
      storageAutoIoScaling: 'Enabled'
      storageSizeGB: 64
      storageIOPS: 400
      backupRetentionDays: 10
      databases: [
        {
          name: 'testdb1'
        }
      ]
      highAvailability: 'SameZone'
      storageAutoGrow: 'Enabled'
      managedIdentities: {
        userAssignedResourceIds: [
          nestedDependencies.outputs.managedIdentityResourceId
        ]
      }
      administrators: [
        {
          identityResourceId: nestedDependencies.outputs.managedIdentityResourceId
          login: nestedDependencies.outputs.managedIdentityName
          sid: nestedDependencies.outputs.managedIdentityPrincipalId
        }
      ]
    }
  }
]
