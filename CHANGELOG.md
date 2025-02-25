# Change log

## AGMPowerLIB (0.0.0.74)
* Add New-AGMLibVMwareVMDiscovery
## AGMPowerLIB (0.0.0.73)
* Minor updates for describing the import of source appIDs for PD snapshots.

## AGMPowerLIB (0.0.0.72)
* disktype was being ignored by New-AGMLibGCPInstanceMultiMount

## AGMPowerLIB (0.0.0.71)
* Enhanced New-AGMLibGCEInstanceDiscovery with gcloud search function as well as filtering and metadata searches

## AGMPowerLIB (0.0.0.70)
* Add jsonprint diag tool to New-AGMLibGCEMountExisting and improved logic in that function

## AGMPowerLIB (0.0.0.69)
* Added Confirm-AGMLibComputeEngineProject and Confirm-AGMLibComputeEngineImage

## AGMPowerLIB (0.0.0.68)
* Reduce number of commands run by New-AGMLibGCEInstanceDiscovery

## AGMPowerLIB (0.0.0.67)
* Improve New-AGMLibLVMMount: only show hosts with agent and show label when producing sample command
* Improve error reporting in New-AGMLibGCEInstanceDiscovery when using textoutput

## AGMPowerLIB (0.0.0.66)
* Improve error reporting in New-AGMLibGCEInstanceDiscovery when using textoutput

## AGMPowerLIB (0.0.0.65)
* Offer no-parallel option on New-AGMLibGCEInstanceDiscovery

## AGMPowerLIB (0.0.0.64)
* New-AGMLibImage was using wrong syntax to check for policyID
* Add New-AGMLibLVMMount

## AGMPowerLIB (0.0.0.63)
* New-AGMLibGCPInstance and New-AGMLibGCPInstanceMultiMount - Support sole tenancy 

## AGMPowerLIB (0.0.0.62)
* New-AGMLibVM add support for restoremacaddr
* New-AGMLibGCVEfailover add support for restoremacaddr

## AGMPowerLIB (0.0.0.61)
* New-AGMLibGCEInstanceDiscovery
* Allow user to use label to specify diskbackup rule. Right now will support only bootonly
 * change -usertag to -backupplanlabel while continuing to support only name
* Import-AGMLibOnVault improved guided mode output 
* New-AGMLibGCVEfailover - ignore HCX node if its discovered and only work with nodes whose name start with esxi

## AGMPowerLIB (0.0.0.60)
* Add New-AGMLibMSSQLClone
* Improve New-AGMLibMSSQLMount so it handles case where selected managed DB is an Instance/CG
* Stop Get-AGMLibActiveImage getting NAS errors on unmount
* Improve error messages from Get-AGMLibApplianceLogs
* Improve help examples in some commands
* Add ostype field to Get-AGMLibHostList

## AGMPowerLIB (0.0.0.59)
* Added Restore-AGMLibSAPHANA to run restores on SAP HANA
* Added New-AGMLibSAPHANAMultiMount to do multi mount for SAP HANA
* Updated Mount-AGMLibSAPHANA to add CSV output to feed New-AGMLibSAPHANAMultiMount
* Minor fixes to New-AGMLibGCPInstance 
* New-AGMLibImage will now look for DirectOnvault job

## AGMPowerLIB (0.0.0.58)
* Get-AGMLibPolicies - added options 
* If version check fails, print actual error. This should surface expired openID Connect tokens 

## AGMPowerLIB (0.0.0.57)
* New-AGMLibGCPInstance 
* was printing a dummy instancename for multi-instance recovery, this was causing issue, so field will be blank
* was not handling host projects correctly, added a new field nicXhostproject to process handle these.

## AGMPowerLIB (0.0.0.56)
* Added Get-AGMLibApplianceLogs

## AGMPowerLIB (0.0.0.55)
* Added Get-AGMLibBackupSKU
* Corrected issue with Set-AGMLibApplianceParameter asking for applianceid when it was supplied

## AGMPowerLIB (0.0.0.54)
Important - upgrade to AGMPowerCLI 0.0.0.39 before upgrading to AGMPowerLib 0.0.0.54

* [GitHub commits](https://github.com/Actifio/AGMPowerLIB/commits/v0.0.0.54)
* New-AGMLibGCPInstance 
  * Offer option to re-use source name and IP. 
  * Offer option to output all VMs into CSV file, not just the one being mounted, dramatically speeding up prep work
  * Offer option to update existing CSV with any new instances protected since last update of the CSV file
  * Allow user to use simple network and subnet names rather than using URL format
* New-AGMLibGCEInstanceDiscovery
  * Allow user to use parameters rather than use a CSV file
  * Offer bootonly option to allow boot drive 
  * Offer sltname and sltid to be used in combination with -backup to auto backup all discovered VMs
  * If usertag is set and the value is 'ignored' or 'unmanaged' then do that rather than try and protect the instance with matching sltname
  * Added parallel execution when run under PS7
* Remove-AGMLibMount 
  * Added parallel execution for Forget GCE Instance when run under PS7
* New-AGMLibGCPInstanceMultiMount 
  * Added parallel execution when run under PS7
* New-AGMLibGCEMountExisting
  * New function to allow mount of a GCE Instance backup to an existing GCE Instance 
* Get-AGMLibApplianceParameter 
  * change to use id rather than applianceid as this was confusing the two IDs. Needs AGMPowerCLI 0.0.0.39
