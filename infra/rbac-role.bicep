param readerUserId string

resource rgReaderAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, 'reader-role-assignment')
  scope: resourceGroup()
  properties: {
    principalId: readerUserId
    roleDefinitionId: subscriptionResourceId(
      'Microsoft.Authorization/roleDefinitions',
      'acdd72a7-3385-48ef-bd42-f606fba81ae7' // Reader
    )
    principalType: 'User'
  }
}
