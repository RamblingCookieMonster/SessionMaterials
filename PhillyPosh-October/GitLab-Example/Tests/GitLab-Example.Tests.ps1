# Ensure BuildHelpers has set the environment up
if(-not $ENV:BHBuildSystem)
{
    Set-BuildEnvironment -Path $PSScriptRoot\..\
}

Describe "$ENV:BHProjectName" {
    Context 'When you run it' {

        # We don't want to actually install a module
        # or run Send-SlackMessage
        Mock Install-Module
        Mock Send-SlackMessage {'Sent!'}

        # Capture output from the script
        $Output = . "$ENV:BHProjectPath\$ENV:BHProjectName\GitLab-Example.ps1" -Force

        It 'Should call Send-SlackMessage' {
            Assert-MockCalled Send-SlackMessage -Exactly -Times 1
            $Output | Should Be 'Sent!'
        }

        It "Should pass if I don't tell it to fail" {
            $ENV:BHCommitMessage | Should Not Match '!Fail'
        }
    }
}