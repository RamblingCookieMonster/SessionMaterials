# You can use PowerShell in PSDeploy files
# Ideally you minimize this, so that a file
# is just a list of deployments...

# Limit when deployments run
if(
    $env:BHBuildSystem -ne 'Unknown' -and
    $env:BHBranchName -eq "master" -and
    $env:BHCommitMessage -match '!deploy' )
{
    Deploy some_script {
        By FileSystem {
            FromSource "$ENV:BHProjectPath\$ENV:BHProjectName"
            To 'C:\ExampleDeployment'
            WithOptions @{
                Mirror = $True
            }
        }
    }
}
else
{
    "Skipping deployment: To deploy, ensure that...`n" +
    "`t* You are in a known build system (Current: $ENV:BHBuildSystem)`n" +
    "`t* You are committing to the master branch (Current: $ENV:BHBranchName) `n" +
    "`t* Your commit message includes !deploy (Current: $ENV:BHCommitMessage)" |
        Write-Host
}