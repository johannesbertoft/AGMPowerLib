# Copyright 2022 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


Function Confirm-AGMLibComputeEngineProject([string]$projectid) 
{
    <#
    .SYNOPSIS
    Matches snapshots in compute engine to snapshots in Backup and DR 

    .EXAMPLE
    Confirm-AGMLibComputeEngineProject -projectid backuppproject1
    Matches all snapshots found in Google Cloud project backuppproject1 to those reported by Compute Engine
    If an image does not have an ID then no matching was found by Backup and DR 

    .DESCRIPTION
    A function to detect if there are snapshots in the specified project that are not being tracked by Backup and DR or by a different instance of Backup and DR.

    #>

    if ( (!($AGMSESSIONID)) -or (!($AGMIP)) )
    {
        Get-AGMErrorMessage -messagetoprint "Not logged in or session expired. Please login using Connect-AGM"
        return
    }
    $sessiontest = Get-AGMVersion
    if ($sessiontest.errormessage)
    {
        $sessiontest
        return
    }
    
    # we depend on Google Cloud module being present
    try
    {
        Import-Module GoogleCloud -ErrorAction SilentlyContinue
    }

    catch
    {
        $retVal = $false
    }
    $moduletest = get-module -name GoogleCloud 
    if (!($moduletest.Version))
    {
        Get-AGMErrorMessage -messagetoprint "GoogleCloud module was not found using Get-Module command"
        return
    }
    if (!($projectid))
    {
        $projectid = Read-Host "Project ID"
    }
    $snapshotgrab =  Get-GceSnapshot -Project $projectid
    if (!($snapshotgrab.Id))
    {
        Get-AGMErrorMessage -messagetoprint "Failed to find any compute engine snapshots using: Get-GceSnapshot -Project $projectid"
        return
    }
    $imagegrab = Get-AGMImage -filtervalue apptype=GCPInstance | select-object id,backupname
    
    if (!($imagegrab.id))
    {
        Get-AGMErrorMessage -messagetoprint "Failed to find any compute engine snapshots on the Management Console using Get-AGMImage -filtervalue apptype=GCPInstance"
        return
    }


    $AGMArray = @()
    Foreach ($snap in $snapshotgrab)
    {
        $id = ""
        $applianceid = ""
        $imagename = ""
        if (($snap.labels).length -gt 0)
        {
            $applianceid = $snap.labels.values.split("-")[0]
            $imagename = $snap.labels.values.split("-")[2]
            if (($imagename).length -gt 0)
            {
                $id =  ($imagegrab | where-object {($_.backupname -eq $imagename)}).id
            }
        }
        
        $AGMArray += [pscustomobject]@{
            id = $id
            project = $projectid
            appliance = $applianceid
            imagename = $imagename
            snapshotname = $snap.Name
            status = $snap.Status
        }
    }
    $AGMArray
}
