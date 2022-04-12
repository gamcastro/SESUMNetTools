function Get-SESUMNetInfo{
    [cmdletbinding()]
    param(
        [string]$Computername
    )
    BEGIN{ }
    PROCESS{
        $ipParams = @{'AddressFamily'= 'IPv4'
                      'InterfaceAlias' = 'Ethernet'
        }
        $ip = (Get-NetIpAddress @ipParams).IPAddress
        $defaultGateway = Get-NetRoute -DestinationPrefix "0.0.0.0/0" | Select-Object -ExpandProperty "NextHop"
        $dnsServers = Get-DnsClientServerAddress -InterfaceAlias "Ethernet" -AddressFamily IPv4 | Select-Object -ExpandProperty ServerAddresses

        $props = @{'IP' = $ip
                    'Default Gateway' = $defaultGateway
                    'DNS' = $dnsServers}

        $obj = New-Object -TypeName psobject -Property $props
        Write-Output $obj
    }
    END{}
}