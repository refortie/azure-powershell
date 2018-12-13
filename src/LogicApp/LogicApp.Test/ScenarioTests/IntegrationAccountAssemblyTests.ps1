# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

 <#
.SYNOPSIS
Test New-AzIntegrationAccountAssembly command
#>
function Test-CreateIntegrationAccountAssembly
{
	$localAssemblyFilePath = Join-Path $TestOutputRoot "\Resources\SampleAssembly.dll"
	$assemblyContent = [IO.File]::ReadAllBytes($localAssemblyFilePath)
	$resourceGroup = TestSetup-CreateResourceGroup
	$integrationAccountName = "IA-" + (getAssetname)
	$integrationAccount = TestSetup-CreateIntegrationAccount $resourceGroup.ResourceGroupName $integrationAccountName
	
	$integrationAccountAssemblyName = "SampleAssemblyFilePath"
	$resultByFilePath = New-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName -AssemblyFilePath $localAssemblyFilePath
	Assert-AreEqual $integrationAccountAssemblyName $resultByFilePath.Name

	$integrationAccountAssemblyName = "SampleAssemblyFilePathInputObject"
	$resultByFilePath = New-AzIntegrationAccountAssembly -InputObject $resultByFilePath -AssemblyName $integrationAccountAssemblyName -AssemblyFilePath $localAssemblyFilePath
	Assert-AreEqual $integrationAccountAssemblyName $resultByFilePath.Name

	$integrationAccountAssemblyName = "SampleAssemblyFilePathId"
	$resultByFilePath = New-AzIntegrationAccountAssembly -ResourceId $resultByFilePath.Id -AssemblyName $integrationAccountAssemblyName -AssemblyFilePath $localAssemblyFilePath
	Assert-AreEqual $integrationAccountAssemblyName $resultByFilePath.Name

	$integrationAccountAssemblyName = "SampleAssemblyBytes"
	$resultByBytes = New-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName -AssemblyData $assemblyContent
	Assert-AreEqual $integrationAccountAssemblyName $resultByBytes.Name

	$integrationAccountAssemblyName = "SampleAssemblyBytesInputObject"
	$resultByBytes = New-AzIntegrationAccountAssembly -InputObject $resultByFilePath -AssemblyName $integrationAccountAssemblyName -AssemblyData $assemblyContent
	Assert-AreEqual $integrationAccountAssemblyName $resultByBytes.Name

	$integrationAccountAssemblyName = "SampleAssemblyBytesId"
	$resultByBytes = New-AzIntegrationAccountAssembly -ResourceId $resultByFilePath.Id -AssemblyName $integrationAccountAssemblyName -AssemblyData $assemblyContent
	Assert-AreEqual $integrationAccountAssemblyName $resultByBytes.Name

	$integrationAccountAssemblyName = "SampleAssemblyContentLink"
	$resultByContentLink = New-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName -ContentLink $resultByBytes.Properties.ContentLink.Uri
	Assert-AreEqual $integrationAccountAssemblyName $resultByContentLink.Name

	$integrationAccountAssemblyName = "SampleAssemblyContentLinkInputObject"
	$resultByContentLink = New-AzIntegrationAccountAssembly -InputObject $resultByFilePath -AssemblyName $integrationAccountAssemblyName -ContentLink $resultByBytes.Properties.ContentLink.Uri
	Assert-AreEqual $integrationAccountAssemblyName $resultByContentLink.Name

	$integrationAccountAssemblyName = "SampleAssemblyContentLinkId"
	$resultByContentLink = New-AzIntegrationAccountAssembly -ResourceId $resultByFilePath.Id -AssemblyName $integrationAccountAssemblyName -ContentLink $resultByBytes.Properties.ContentLink.Uri
	Assert-AreEqual $integrationAccountAssemblyName $resultByContentLink.Name

	$integrationAccountAssemblyName = "SampleAssemblyInputObject"
	$result = New-AzIntegrationAccountAssembly -AssemblyName $integrationAccountAssemblyName -InputObject $resultByContentLink
	Assert-AreEqual $integrationAccountAssemblyName $result.Name

	$integrationAccountAssemblyName = "SampleAssemblyId"
	$result = New-AzIntegrationAccountAssembly -AssemblyName $integrationAccountAssemblyName -ResourceId $resultByContentLink.Id
	Assert-AreEqual $integrationAccountAssemblyName $result.Name

	$integrationAccountAssemblyName = "SampleAssemblyNoData"
	Assert-ThrowsContains { New-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName } "must have either 'content' or 'contentLink' property set."

	Remove-AzIntegrationAccount -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -Force
}

 <#
.SYNOPSIS
Test Get-AzIntegrationAccountAssembly command
#>
function Test-GetIntegrationAccountAssembly
{
	$localAssemblyFilePath = Join-Path $TestOutputRoot "\Resources\SampleAssembly.dll"
 	$resourceGroup = TestSetup-CreateResourceGroup
	$integrationAccountName = "IA-" + (getAssetname)
 	$integrationAccount = TestSetup-CreateIntegrationAccount $resourceGroup.ResourceGroupName $integrationAccountName
	
	$integrationAccountAssemblyName = "SampleAssembly"
	$integrationAccountAssembly = New-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName -AssemblyFilePath $localAssemblyFilePath
	Assert-AreEqual $integrationAccountAssemblyName $integrationAccountAssembly.Name

 	$resultByName = Get-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssembly.Name
	Assert-AreEqual $integrationAccountAssemblyName $resultByName.Name

	$resultByResourceId = Get-AzIntegrationAccountAssembly -ResourceId $integrationAccountAssembly.Id
	Assert-AreEqual $integrationAccountAssemblyName $resultByResourceId.Name

	$resultByPipingResourceId = Get-AzIntegrationAccountAssembly -ResourceId $integrationAccountAssembly.Id | Get-AzIntegrationAccountAssembly
	Assert-AreEqual $integrationAccountAssemblyName $resultByPipingResourceId.Name

	$resultByInputObject = Get-AzIntegrationAccountAssembly -InputObject $integrationAccountAssembly
	Assert-AreEqual $integrationAccountAssemblyName $resultByInputObject.Name

	$resultByPipingInputObject = $integrationAccountAssembly | Get-AzIntegrationAccountAssembly
	Assert-AreEqual $integrationAccountAssemblyName $resultByPipingInputObject.Name

 	Remove-AzIntegrationAccount -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -Force
}

 <#
.SYNOPSIS
Test Get-AzIntegrationAccountAssembly command : List
#>
function Test-ListIntegrationAccountAssembly
{
	$localAssemblyFilePath = Join-Path $TestOutputRoot "\Resources\SampleAssembly.dll"
	$resourceGroup = TestSetup-CreateResourceGroup
	$integrationAccountName = "IA-" + (getAssetname)
	$integrationAccount = TestSetup-CreateIntegrationAccount $resourceGroup.ResourceGroupName $integrationAccountName
	
	$integrationAccountAssemblyName = "SampleAssembly"
	
	$val=0
	while($val -ne 3)
	{
		$val++;
		$integrationAccountAssemblyName = "Assembly-$val-" + (getAssetname)
		$integrationAccountAssembly = New-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName -AssemblyFilePath $localAssemblyFilePath
	}

	$result =  Get-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName
	Assert-True { $result.Count -eq 3 }

	Remove-AzIntegrationAccount -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -Force
}

 <#
.SYNOPSIS
Test Remove-AzIntegrationAccountAssembly command
#>
function Test-RemoveIntegrationAccountAssembly
{
	$localAssemblyFilePath = Join-Path $TestOutputRoot "\Resources\SampleAssembly.dll"
	$resourceGroup = TestSetup-CreateResourceGroup
	$integrationAccountName = "IA-" + (getAssetname)
	$integrationAccount = TestSetup-CreateIntegrationAccount $resourceGroup.ResourceGroupName $integrationAccountName
	
	$integrationAccountAssemblyName = "SampleAssembly"
	$integrationAccountAssembly = New-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName -AssemblyFilePath $localAssemblyFilePath
	Remove-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName

	$integrationAccountAssembly = New-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName -AssemblyFilePath $localAssemblyFilePath
	Remove-AzIntegrationAccountAssembly -ResourceId $integrationAccountAssembly.Id

	$integrationAccountAssembly = New-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName -AssemblyFilePath $localAssemblyFilePath
	Remove-AzIntegrationAccountAssembly -InputObject $integrationAccountAssembly

	$integrationAccountAssembly = New-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName -AssemblyFilePath $localAssemblyFilePath
	$integrationAccountAssembly | Remove-AzIntegrationAccountAssembly

	Remove-AzIntegrationAccount -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -Force
}

 <#
.SYNOPSIS
Test Set-AzIntegrationAccountAssembly command
#>
function Test-UpdateIntegrationAccountAssembly
{
	$localAssemblyFilePath = Join-Path $TestOutputRoot "\Resources\SampleAssembly.dll"
	$assemblyContent = [IO.File]::ReadAllBytes($localAssemblyFilePath)
	$resourceGroup = TestSetup-CreateResourceGroup
	$integrationAccountName = "IA-" + (getAssetname)
	$integrationAccount = TestSetup-CreateIntegrationAccount $resourceGroup.ResourceGroupName $integrationAccountName
	
	$integrationAccountAssemblyName = "SampleAssemblyFilePath"
	$integrationAccountAssembly = New-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName -AssemblyFilePath $localAssemblyFilePath
	Assert-AreEqual $integrationAccountAssemblyName $integrationAccountAssembly.Name
	
	$resultByFilePath = Set-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName -AssemblyFilePath $localAssemblyFilePath
	Assert-AreEqual $integrationAccountAssemblyName $resultByFilePath.Name

	$resultByFilePath = Set-AzIntegrationAccountAssembly -InputObject $resultByFilePath -AssemblyFilePath $localAssemblyFilePath
	Assert-AreEqual $integrationAccountAssemblyName $resultByFilePath.Name

	$resultByFilePath = Set-AzIntegrationAccountAssembly -ResourceId $resultByFilePath.Id -AssemblyFilePath $localAssemblyFilePath
	Assert-AreEqual $integrationAccountAssemblyName $resultByFilePath.Name

	$integrationAccountAssemblyName = "SampleAssemblyBytes"
	$integrationAccountAssembly = New-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName -AssemblyData $assemblyContent
	Assert-AreEqual $integrationAccountAssemblyName $integrationAccountAssembly.Name

	$resultByBytes = Set-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName -AssemblyData $assemblyContent
	Assert-AreEqual $integrationAccountAssemblyName $resultByBytes.Name

	$resultByBytes = Set-AzIntegrationAccountAssembly -InputObject $integrationAccountAssembly -AssemblyData $assemblyContent
	Assert-AreEqual $integrationAccountAssemblyName $resultByBytes.Name

	$resultByBytes = Set-AzIntegrationAccountAssembly -ResourceId $integrationAccountAssembly.Id -AssemblyData $assemblyContent
	Assert-AreEqual $integrationAccountAssemblyName $resultByBytes.Name

	$integrationAccountAssemblyName = "SampleAssemblyContentLink"
	$integrationAccountAssembly = New-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName -ContentLink $resultByBytes.Properties.ContentLink.Uri
	Assert-AreEqual $integrationAccountAssemblyName $integrationAccountAssembly.Name

	$resultByContentLink = Set-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName -ContentLink $resultByBytes.Properties.ContentLink.Uri
	Assert-AreEqual $integrationAccountAssemblyName $resultByContentLink.Name

	$resultByContentLink = Set-AzIntegrationAccountAssembly -InputObject $integrationAccountAssembly -ContentLink $resultByBytes.Properties.ContentLink.Uri
	Assert-AreEqual $integrationAccountAssemblyName $resultByContentLink.Name

	$resultByContentLink = Set-AzIntegrationAccountAssembly -ResourceId $integrationAccountAssembly.Id -ContentLink $resultByBytes.Properties.ContentLink.Uri
	Assert-AreEqual $integrationAccountAssemblyName $resultByContentLink.Name

	Remove-AzIntegrationAccount -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -Force
}

 <#
.SYNOPSIS
Test end to end piping
#>
function Test-EndToEndAssemblyPiping
{
	$localAssemblyFilePath = Join-Path $TestOutputRoot "\Resources\SampleAssembly.dll"
 	$resourceGroup = TestSetup-CreateResourceGroup
	$integrationAccountName = "IA-" + (getAssetname)
	$integrationAccount = TestSetup-CreateIntegrationAccount $resourceGroup.ResourceGroupName $integrationAccountName
	
	$integrationAccountAssemblyName = "SampleAssembly"
	New-AzIntegrationAccountAssembly -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -AssemblyName $integrationAccountAssemblyName -AssemblyFilePath $localAssemblyFilePath | Get-AzIntegrationAccountAssembly | Set-AzIntegrationAccountAssembly | Remove-AzIntegrationAccountAssembly

 	Remove-AzIntegrationAccount -ResourceGroupName $resourceGroup.ResourceGroupName -IntegrationAccountName $integrationAccountName -Force
}