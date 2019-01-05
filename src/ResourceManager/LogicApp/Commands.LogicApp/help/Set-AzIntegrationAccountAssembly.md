---
external help file: Microsoft.Azure.PowerShell.Cmdlets.LogicApp.dll-Help.xml
Module Name: Az.LogicApp
online version:
schema: 2.0.0
---

# Set-AzIntegrationAccountAssembly

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### ByIntegrationAccountAndFilePath (Default)
```
Set-AzIntegrationAccountAssembly -ResourceGroupName <String> -ParentName <String> -Name <String>
 -AssemblyFilePath <String> [-Metadata <JObject>] [-DefaultProfile <IAzureContextContainer>]
 [<CommonParameters>]
```

### ByIntegrationAccountAndContentLink
```
Set-AzIntegrationAccountAssembly -ResourceGroupName <String> -ParentName <String> -Name <String>
 -ContentLink <String> [-Metadata <JObject>] [-DefaultProfile <IAzureContextContainer>] [<CommonParameters>]
```

### ByIntegrationAccountAndFileBytes
```
Set-AzIntegrationAccountAssembly -ResourceGroupName <String> -ParentName <String> -Name <String>
 -AssemblyData <Byte[]> [-Metadata <JObject>] [-DefaultProfile <IAzureContextContainer>] [<CommonParameters>]
```

### ByInputObjectAndFilePath
```
Set-AzIntegrationAccountAssembly -AssemblyFilePath <String> [-Metadata <JObject>]
 -InputObject <AssemblyDefinition> [-DefaultProfile <IAzureContextContainer>] [<CommonParameters>]
```

### ByResourceIdAndFilePath
```
Set-AzIntegrationAccountAssembly -AssemblyFilePath <String> [-Metadata <JObject>] -ResourceId <String>
 [-DefaultProfile <IAzureContextContainer>] [<CommonParameters>]
```

### ByInputObjectAndFileBytes
```
Set-AzIntegrationAccountAssembly -AssemblyData <Byte[]> [-Metadata <JObject>] -InputObject <AssemblyDefinition>
 [-DefaultProfile <IAzureContextContainer>] [<CommonParameters>]
```

### ByResourceIdAndFileBytes
```
Set-AzIntegrationAccountAssembly -AssemblyData <Byte[]> [-Metadata <JObject>] -ResourceId <String>
 [-DefaultProfile <IAzureContextContainer>] [<CommonParameters>]
```

### ByInputObjectAndContentLink
```
Set-AzIntegrationAccountAssembly -ContentLink <String> [-Metadata <JObject>] -InputObject <AssemblyDefinition>
 [-DefaultProfile <IAzureContextContainer>] [<CommonParameters>]
```

### ByResourceIdAndContentLink
```
Set-AzIntegrationAccountAssembly -ContentLink <String> [-Metadata <JObject>] -ResourceId <String>
 [-DefaultProfile <IAzureContextContainer>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -AssemblyData
The integration account assembly byte data.

```yaml
Type: System.Byte[]
Parameter Sets: ByIntegrationAccountAndFileBytes, ByInputObjectAndFileBytes, ByResourceIdAndFileBytes
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssemblyFilePath
The integration account assembly file path.

```yaml
Type: System.String
Parameter Sets: ByIntegrationAccountAndFilePath, ByInputObjectAndFilePath, ByResourceIdAndFilePath
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContentLink
A publicly accessible link to the integration account assembly data.

```yaml
Type: System.String
Parameter Sets: ByIntegrationAccountAndContentLink, ByInputObjectAndContentLink, ByResourceIdAndContentLink
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultProfile
The credentials, account, tenant, and subscription used for communication with Azure.

```yaml
Type: Microsoft.Azure.Commands.Common.Authentication.Abstractions.Core.IAzureContextContainer
Parameter Sets: (All)
Aliases: AzContext, AzureRmContext, AzureCredential

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
An integration account assembly.

```yaml
Type: Microsoft.Azure.Management.Logic.Models.AssemblyDefinition
Parameter Sets: ByInputObjectAndFilePath, ByInputObjectAndFileBytes, ByInputObjectAndContentLink
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Metadata
The integration account assembly metadata.

```yaml
Type: Newtonsoft.Json.Linq.JObject
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The integration account assembly name.

```yaml
Type: System.String
Parameter Sets: ByIntegrationAccountAndFilePath, ByIntegrationAccountAndContentLink, ByIntegrationAccountAndFileBytes
Aliases: AssemblyName, ResourceName

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParentName
The integration account name.

```yaml
Type: System.String
Parameter Sets: ByIntegrationAccountAndFilePath, ByIntegrationAccountAndContentLink, ByIntegrationAccountAndFileBytes
Aliases: IntegrationAccountName

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
The integration account resource group name.

```yaml
Type: System.String
Parameter Sets: ByIntegrationAccountAndFilePath, ByIntegrationAccountAndContentLink, ByIntegrationAccountAndFileBytes
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
The integration account assembly resource id.

```yaml
Type: System.String
Parameter Sets: ByResourceIdAndFilePath, ByResourceIdAndFileBytes, ByResourceIdAndContentLink
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### Microsoft.Azure.Management.Logic.Models.AssemblyDefinition

## OUTPUTS

### Microsoft.Azure.Management.Logic.Models.AssemblyDefinition

## NOTES

## RELATED LINKS
