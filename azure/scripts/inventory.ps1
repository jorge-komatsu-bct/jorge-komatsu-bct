# Install Azure PowerShell module if not already installed
# Install-Module -Name Az -AllowClobber -Scope CurrentUser

# Import the Az module
Import-Module Az

# Sign in to Azure using a browser window
Connect-AzAccount

# Get all subscriptions for the signed-in user
$subscriptions = Get-AzSubscription

# Loop through each subscription
foreach ($subscription in $subscriptions) {
    # Set the current subscription context
    Set-AzContext -Subscription $subscription.Id

    # Get all resource groups in the current subscription
    $resourceGroups = Get-AzResourceGroup

    # Create an array to store VM information
$vmInfo = @()

# Loop through each resource group
foreach ($resourceGroup in $resourceGroups) {
    Write-Host "Resource Group: $($resourceGroup.ResourceGroupName)"

    # Get all resources in the current resource group
    $resources = Find-AzResource -ResourceGroupName $resourceGroup.ResourceGroupName

    # Loop through each resource
    foreach ($resource in $resources) {
        Write-Host "Resource Name: $($resource.Name)"

        # Check if the resource is a VM
        if ($resource.Type -eq "Microsoft.Compute/virtualMachines") {
            $vm = Get-AzVM -ResourceGroupName $resourceGroup.ResourceGroupName -Name $resource.Name

            # Check if the VM is Linux
            if ($vm.StorageProfile.OsDisk.OsType -eq "Linux") {
                # Run a bash command on the Linux VM
                # Example: $output = Invoke-AzVMRunCommand -ResourceGroupName $resourceGroup.ResourceGroupName -VMName $resource.Name -CommandId 'RunShellScript' -Script "/path/to/bash/script.sh"
            }
            elseif ($vm.StorageProfile.OsDisk.OsType -eq "Windows") {
                # Run a shell command on the Windows VM
                # Example: $output = Invoke-AzVMRunCommand -ResourceGroupName $resourceGroup.ResourceGroupName -VMName $resource.Name -CommandId 'RunPowerShellScript' -Script "/path/to/powershell/script.ps1"
            }

            # Add VM information to the array
            $vmInfo += [PSCustomObject]@{
                "ResourceGroupName" = $resourceGroup.ResourceGroupName
                "VMName" = $vm.Name
                "VMOS" = $vm.StorageProfile.OsDisk.OsType
                # Add more properties as needed
            }
        }
    }
}

}
