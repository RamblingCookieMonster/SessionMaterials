# Example script...

Install-Module PSSlack -Force
<#
    Logic that might prevent Send-SlackMessage from running!
    Tests will ensure that Send-SlackMessage ran
#>

New-SlackMessageAttachment -Title 'The System Is Down' `
                           -TitleLink https://www.youtube.com/watch?v=TmpRs7xN06Q `
                           -Text 'Please Do The Needful' `
                           -Pretext 'Everything is broken' `
                           -AuthorName 'SCOM Bot' `
                           -AuthorIcon 'http://ramblingcookiemonster.github.io/images/tools/wrench.png' `
                           -Fallback 'Your client is bad' |
    New-SlackMessage -Channel '@wframe' `
                     -IconEmoji :bomb: |
    Send-SlackMessage -Token 'TokenThatShouldBeEncrypted'