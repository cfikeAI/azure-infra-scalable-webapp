param location string = 'eastus'
param adminUsername string = 'azureuser'
@secure()
param sshPublicKey string

resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: 'vnet1'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'subnet'
        properties: {
          addressPrefix: '10.0.0.0/24'
          networkSecurityGroup: {
            id: nsg.id
          } 
        }
      }
    ]
  }
  tags: {
  owner: 'chad'
  env: 'dev'
}
}

resource nic 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: 'vm-nic'
  location: location
  properties: {
    networkSecurityGroup: {
      id: nsg.id
    }
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          
          publicIPAddress: {
            id: publicIp.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, 'subnet')
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
  tags: {
  owner: 'chad'
  env: 'dev'
}
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: 'vm-pip'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    dnsSettings: {
      domainNameLabel: 'demo-vm-cfikeai'
    }
  }
  tags: {
  owner: 'chad'
  env: 'dev'
}
}



resource nsg 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: 'nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'allow-SSH-MyIP'
        properties: {
          priority: 1000
          protocol: 'Tcp'
          access: 'Allow' 
          direction: 'Inbound'
          sourceAddressPrefix: '172.56.3.110' 
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '22'
        }
      }
    ]
  }
  tags: {
  owner: 'chad'
  env: 'dev'
}
}

resource vm 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: 'vm'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
      dataDisks: [
    {
        lun: 0
        name: dataDisk.name
        createOption: 'Attach'
        managedDisk: {
          id: dataDisk.id
        }
      }
    ]
  }
    osProfile: {
      computerName: 'demo-vm'
      adminUsername: adminUsername
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/${adminUsername}/.ssh/authorized_keys'
              keyData: sshPublicKey
            }
          ]
        }
      }
    } 
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}

resource dataDisk 'Microsoft.Compute/disks@2023-01-02' = {
  name: 'vm-datadisk'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    creationData: {
      createOption: 'Empty'
    }
    diskSizeGB: 32
  }
  tags: {
  owner: 'chad'
  env: 'dev'
}
}
