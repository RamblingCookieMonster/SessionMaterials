# For this demo, clear the example target so we can test later
    Remove-Item C:\ExampleDeploymet -Force -Recurse -ErrorAction SilentlyContinue

# Grab nuget bits, module dependencies, set build variables
    Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null
    $Modules = echo BuildHelpers, PSDeploy, Pester
    Install-Module -Force -Name $Modules
    Import-Module $Modules
    Set-BuildEnvironment

# Display build details
    $lines = '-' * 70
    $lines
    "Build System Details:"
    Get-Item ENV:BH*
    "`n"

# Run tests, deployment
    $lines
    "`n`tSTATUS: Testing with PowerShell $($PSVersionTable.PSVersion)"
    $TestOutput = Invoke-Pester -Passthru
    if($TestOutput.FailedCount -gt 0){
        throw 'Pester tests failed, terminating build'
    }
    Invoke-PSDeploy -Force
    "`n"

# Did we actually deploy?
    $lines
    "`nDeployed Files:"
    ( Get-ChildItem C:\ExampleDeployment -ErrorAction SilentlyContinue ).FullName