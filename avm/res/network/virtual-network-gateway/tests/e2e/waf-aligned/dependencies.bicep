@description('Optional. The location to deploy resources to.')
param location string = resourceGroup().location

@description('Required. The name of the Virtual Network to create.')
param virtualNetworkName string

@description('Required. The name of the Local Network Gateway to create.')
param localNetworkGatewayName string

@description('Required. The name of the Maintenance Configuration to create.')
param MaintenanceConfigurationName string

@description('Optional. The base time for the deployment, used for generating unique names.')
param baseTime string = utcNow('u')

var addressPrefix = '10.0.0.0/16'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: cidrSubnet(addressPrefix, 16, 0)
        }
      }
    ]
  }
}

resource localNetworkGateway 'Microsoft.Network/localNetworkGateways@2024-07-01' = {
  name: localNetworkGatewayName
  location: location
  properties: {
    gatewayIpAddress: '100.100.100.100'
    localNetworkAddressSpace: {
      addressPrefixes: [
        '192.168.0.0/24'
      ]
    }
  }
}

resource maintenanceConfiguration 'Microsoft.Maintenance/maintenanceConfigurations@2023-04-01' = {
  name: MaintenanceConfigurationName
  location: location
  properties: {
    maintenanceScope: 'Resource'
    extensionProperties: {
      maintenanceSubScope: 'NetworkGatewayMaintenance'
    }
    maintenanceWindow: {
      startDateTime: dateTimeAdd(baseTime, 'P2D', 'yyyy-MM-dd HH:mm')
      expirationDateTime: null
      duration: '05:00'
      timeZone: 'Pacific Standard Time'
      recurEvery: 'Day'
    }
  }
}
@description('The resource ID of the created Virtual Network.')
output vnetResourceId string = virtualNetwork.id

@description('The resource ID of the created Local Network Gateway.')
output localNetworkGatewayResourceId string = localNetworkGateway.id

@description('The resource ID of the created Maintenance Configuration.')
output maintenanceConfigurationResourceId string = maintenanceConfiguration.id
