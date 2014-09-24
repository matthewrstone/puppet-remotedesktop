# == Class: remotedesktop
#
# Full description of class remotedesktop here.
#
# === Parameters
#
# Document parameters here.
#
# $ensure           present | absent
# $nla              present | absent
# $port             port number for remote desktop
# $manage_firewall  manage windows firewall configuration - true | false
# === Variables
#
# Here you should define a list of variables that this module would require.
#
#  class { 'remotedesktop' :
#    ensure   => present,
#    port     => 3389,
#    nla => absent,
#  }
#
# See README.md for more examples.
#
# === Authors
#
# Matthew Stone <matt@souldo.net>
#
# === Copyright
#
# Copyright 2014 Matthew Stone, unless otherwise noted.
#
class remotedesktop (
  $ensure          = present,
  $nla             = present,
  $port            = 3389,
  $manage_firewall = false,
) {

  wmi { 'Remote Desktop - Network Level Authentication' :
    wmi_namespace => 'root/cimv2/terminalservices',
    wmi_class     => 'Win32_TSGeneralSetting',
    wmi_property  => 'UserAuthenticationRequired',
    wmi_value     => 1,
  }

  wmi { 'Remote Desktop - Allow Connections' :
    wmi_namespace => 'root/cimv2/terminalservices',
    wmi_class     => 'Win32_TerminalServiceSetting',
    wmi_property  => 'AllowTSConnections',
    wmi_value     => 1,
  }

  class { 'remotedesktop::port' : }
}
