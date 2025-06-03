
targetScope = 'subscription'

param location string = 'eastus'

resource rgWebApp 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-webapp'
  location: location
}

resource rgMonitoring 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-monitoring'
  location: location
}

param readerUserId string = 'a97993b3-7a9c-40e7-93ab-5ac62ddfe956' //cloud ops user

module rbac 'rbac-role.bicep' = {
  name: 'assignReaderToRG'
  scope: rgWebApp
  params: {
    readerUserId: readerUserId
  }
}
