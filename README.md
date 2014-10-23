# remotedesktop

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What remotedesktop affects](#what-remotedesktop-affects)
    * [Setup requirements](#setup-requirements)
4. [Usage](#usage)
5. [Changelog](#changelog)


## Overview

The remotedesktop module allows you to manage your remote desktop service on Windows 2008/2012, including the listening port and Windows firewall setting.

## Module Description

Short version, use this module to enable/disable remote desktop and the Network Level Authentication (NLA) settings so you can connect to your Windows Server.

Long version, lots of people like to change the listening port for RDP, so if you specify a port parameter you can do this without ever having to look at an ugly registry key.  Optionally, you can specify to manage the existing Windows firewall ruleset to update to the new setting.

## Setup

### What remotedesktop affects

* modifies the Terminal Services WMI object to allow RDP connections.
* modifies the Terminal Services WMI object to set NLA policy.
* modifies the registry key for RDP TCP port. (if configured)
* modifies the windows firewall rule for RDP. (if configured)
* restarts the Remote Desktop Services service.

### Setup Requirements 

This module has only been tested with Powershell 3 and up.  Please ensure you are using a newer version of Powershell before using this module.

## Usage

By default, applying this module with no parameters will enable remotedesktop with NLA enabled.  

**Example 1: Enable remotedesktop with NLA enabled**

	class { 'remotedesktop' : }
	
**Example 2: Enable remotedesktop with NLA disabled.**

	class { 'remotedesktop' : 
	  ensure => present,
	  nla    => absent,
	}
	  
**Example 3: Change the Port, Manage Windows Firewall**

	class { 'remotedesktop' :
	  ensure          => present,
      port            => 4926,
      manage_firewall => true,
    }

## CHANGELOG

v1.0.2
------
- Code cleanup

v1.0.1
------
- Metadata fixes

v1.0.0
------
- Initial release
