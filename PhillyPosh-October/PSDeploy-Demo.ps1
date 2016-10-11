# Installation, if you have PowerShell 5, or the PowerShellGet module:
    Install-Module PSDeploy -Force

# Import the module.
    Import-Module PSDeploy

# Get commands in the module
    Get-Command -Module PSDeploy

# Get help for the module and a command
    Get-Help about_PSDeploy
    Get-Help Invoke-PSDeploy -full

# Set up a demo environment
    $null = mkdir C:\0PSDeployDemo
    $null = mkdir C:\0PSDeployDemo\SomeScripts
    $null = mkdir C:\0PSDeployDemo\MyModule
    $null = New-Item -ItemType File -Path C:\0PSDeployDemo\SomeScripts\Script1.ps1
    $null = New-Item -ItemType File -Path C:\0PSDeployDemo\SomeScripts\Script2.ps1
    $null = New-Item -ItemType File -Path C:\0PSDeployDemo\MyModule\MyModule.psd1
    $null = New-Item -ItemType File -Path C:\0PSDeployDemo\MyModule\MyModule.psm1

    Set-Content C:\0PSDeployDemo\demo.psdeploy.ps1 -Value @'
    Deploy ExampleDeployment {

    By FileSystem Scripts {
        FromSource 'SomeScripts'
        To 'C:\PSDeployTo'
        Tagged Dev
        DependingOn ExampleDeployment-Modules
    }

    By FileSystem Modules {
        FromSource MyModule
        To C:\PSDeployTo\MyModule
        Tagged Prod, Module
        WithOptions @{
            Mirror = $true
        }
    }
}
'@

# Deployment scripts - *.psdeploy.ps1
    ise C:\0PSDeployDemo\demo.psdeploy.ps1

# What's in that deployment script?
    Get-PSDeployment -Path C:\0PSDeployDemo\demo.psdeploy.ps1
    Get-PSDeployment -Path C:\0PSDeployDemo\demo.psdeploy.ps1 |
        Select -Property *

# Deployment types - FileSystem, PSGalleryModule, etc.
    ise $PSDeployPath\PSDeployScripts\FileSystem.ps1

# Run it!
    cd C:\0PSDeployDemo
    test-path C:\psdeployto
    Invoke-PSDeploy -Force

# Did it blend?
    dir C:\PSDeployTo -Recurse | select -ExpandProperty fullname
    Remove-Item C:\PSDeployTo -Recurse -Force

# Module dev build deployment example. Idea/code borrowed from Microsoft DSC Resources.
# More details: http://psdeploy.readthedocs.io/en/latest/Example-AppVeyorModule-Deployment/
    ise C:\Users\wframe\Documents\GitHub\PSSlack\deploy.psdeploy.ps1
    Register-PSRepository -Name PSSlackDev `
                          -SourceLocation https://ci.appveyor.com/nuget/psslack `
                          -InstallationPolicy Trusted

    Find-Module -Repository PSSlackDev

    & 'C:\Program Files\Internet Explorer\iexplore.exe' 'https://ci.appveyor.com/project/RamblingCookieMonster/psslack/build/artifacts'