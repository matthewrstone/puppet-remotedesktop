# Remote Desktop Port
class remotedesktop::port (
  $rdp_port = $::remotedesktop::port,
  $firewall = $::remotedesktop::manage_firewall,
) {

  $fw_array = [ 'v2.20','Action=Allow','Active=TRUE','Dir=In','Protocol=6',
    "LPort=${rdp_port}",'App=%SystemRoot%\system32\svchost.exe','Svc=termservice',
    'Name=@FirewallAPI.dll,-28775','Desc=Remote Desktop (Puppet)','EmbedCtxt=@FirewallAPI.dll,-28752|', ]
  $fw_data = join($fw_array,'|')

  registry_value { 'HKLM\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\PortNumber' :
    ensure => present,
    type   => 'dword',
    data   => $rdp_port,
  }
  case $firewall {
    true   : {
      registry_value { 'HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules\RemoteDesktop-UserMode-In-TCP':
        ensure => present,
        data   => $fw_data,
      }
    }
    default  : { }
  }
  exec { 'Restart Terminal Services' :
    command     => "net stop TermService /y; net start TermService",
    refreshonly => true,
    subscribe   => Registry_value['HKLM\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\PortNumber'],
    provider    => powershell,
  }
}

