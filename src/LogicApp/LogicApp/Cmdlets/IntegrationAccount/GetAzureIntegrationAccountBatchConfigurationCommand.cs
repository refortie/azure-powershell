// ----------------------------------------------------------------------------------
//
// Copyright Microsoft Corporation
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ----------------------------------------------------------------------------------
namespace Microsoft.Azure.Commands.LogicApp.Cmdlets
{
    using Microsoft.Azure.Commands.LogicApp.Utilities;
    using Microsoft.Azure.Commands.ResourceManager.Common;
    using Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters;
    using Microsoft.Azure.Management.Internal.Resources.Utilities.Models;
    using Microsoft.Azure.Management.Logic.Models;
    using System.Management.Automation;

    /// <summary>
    /// Gets the integration account batch configuration by name 
    /// </summary>
    [Cmdlet(VerbsCommon.Get, AzureRMConstants.AzureRMPrefix + "IntegrationAccountBatchConfiguration", DefaultParameterSetName = ParameterSet.ByIntegrationAccount)]
    [OutputType(typeof(BatchConfiguration))]
    public class GetAzureIntegrationAccountBatchConfigurationCommand : LogicAppBaseCmdlet
    {
        #region Input Parameters

        [Parameter(Mandatory = true, HelpMessage = Constants.ResourceGroupHelpMessage, ParameterSetName = ParameterSet.ByIntegrationAccount)]
        [ResourceGroupCompleter]
        [ValidateNotNullOrEmpty]
        public string ResourceGroupName { get; set; }

        [Parameter(Mandatory = true, HelpMessage = Constants.IntegrationAccountNameHelpMessage, ParameterSetName = ParameterSet.ByIntegrationAccount)]
        [ResourceNameCompleter("Microsoft.Logic/integrationAccounts", nameof(ResourceGroupName))]
        [ValidateNotNullOrEmpty]
        [Alias("IntegrationAccountName")]
        public string ParentName { get; set; }

        [Parameter(Mandatory = false, HelpMessage = Constants.BatchConfigurationNameHelpMessage, ParameterSetName = ParameterSet.ByInputObject)]
        [Parameter(Mandatory = false, HelpMessage = Constants.BatchConfigurationNameHelpMessage, ParameterSetName = ParameterSet.ByResourceId)]
        [Parameter(Mandatory = false, HelpMessage = Constants.BatchConfigurationNameHelpMessage, ParameterSetName = ParameterSet.ByIntegrationAccount)]
        [ResourceNameCompleter("Microsoft.Logic/integrationAccounts/batchConfigurations", nameof(ResourceGroupName), nameof(ParentName))]
        [ValidateNotNullOrEmpty]
        [Alias("BatchConfigurationName", "ResourceName")]
        public string Name { get; set; }

        [Parameter(Mandatory = true, HelpMessage = Constants.IntegrationAccountObjectHelpMessage, ParameterSetName = ParameterSet.ByInputObject, ValueFromPipeline = true)]
        [ValidateNotNullOrEmpty]
        public IntegrationAccount InputObject { get; set; }

        [Parameter(Mandatory = true, HelpMessage = Constants.IntegrationAccountResourceIdHelpMessage, ParameterSetName = ParameterSet.ByResourceId, ValueFromPipelineByPropertyName = true)]
        [ValidateNotNullOrEmpty]
        public string ResourceId { get; set; }

        #endregion Input Parameters

        /// <summary>
        /// Executes the get integration account batch configuration command.
        /// </summary>
        public override void ExecuteCmdlet()
        {
            base.ExecuteCmdlet();

            if (this.ParameterSetName == ParameterSet.ByInputObject)
            {
                var parsedResourceId = new ResourceIdentifier(this.InputObject.Id);
                this.ResourceGroupName = parsedResourceId.ResourceGroupName;
                this.ParentName = parsedResourceId.ResourceName;
            }
            else if (this.ParameterSetName == ParameterSet.ByResourceId)
            {
                var parsedResourceId = new ResourceIdentifier(this.ResourceId);
                this.ResourceGroupName = parsedResourceId.ResourceGroupName;
                this.ParentName = parsedResourceId.ResourceName;
            }

            if (string.IsNullOrEmpty(this.Name))
            {
                this.WriteObject(this.IntegrationAccountClient.ListIntegrationAccountBatchConfigurations(this.ResourceGroupName, this.ParentName), true);
            }
            else
            {
                this.WriteObject(this.IntegrationAccountClient.GetIntegrationAccountBatchConfiguration(this.ResourceGroupName, this.ParentName, this.Name));
            }
        }
    }
}