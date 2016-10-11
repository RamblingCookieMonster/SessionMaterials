# PhillyPosh October 2016

* Topic: Continuous Deployment for Microsoft Sysadmins

## Materials

* Youtube recording - Coming soon
* [Slides](https://docs.google.com/presentation/d/1OxbBMYD3IPjqFKC8Cl1z4N90OuaW_NIY3C9PgdwZSZ0/edit?usp=sharing)
* Code - Coming soon

## References

* [The Release Pipeline Model](https://aka.ms/TRPM) - Thanks to Michael Greene and Steven Murawski
* Solutions mentioned:
  * Source: [GitHub](https://github.com/pricing)
  * Source: [Gogs](https://gogs.io/) < Simple, free, cross-platform
  * Source, Build: [GitLab CE](https://about.gitlab.com/features/) < A personal favorite
  * Source, Build, Release: [VSTS](https://www.visualstudio.com/team-services/)
  * Build: [Jenkins](https://jenkins.io/)
  * Build, Release: [AppVeyor](https://www.appveyor.com/)
  * Test: [Pester](https://github.com/pester/Pester)
  * Release: [Octopus Deploy](https://octopus.com/)
  * Release: [PSDeploy](https://github.com/RamblingCookieMonster/PSDeploy)
  * Jenkins series from Matt Hodgkins ([one](https://hodgkins.io/automating-with-jenkins-and-powershell-on-windows-part-1), [two](https://hodgkins.io/automating-with-jenkins-and-powershell-on-windows-part-2))
* Build config file references:
  * [.gitlab-ci.yml](https://docs.gitlab.com/ce/ci/yaml/README.html)
  * [appveyor.yml](https://www.appveyor.com/docs/appveyor-yml/)
  * [jenkinsfile](https://jenkins.io/doc/pipeline/jenkinsfile/)
* Pester-oriented Projects:
  * [Pester](https://github.com/pester/Pester)
  * [OVF](https://github.com/PowerShell/Operation-Validation-Framework)
  * [PoshSpec](https://github.com/Ticketmaster/poshspec)
  * [Watchmen](https://github.com/devblackops/watchmen)
  * [Vester](https://github.com/WahlNetwork/Vester)
* [Test Kitchen](https://gaelcolas.com/2016/07/11/introduction-to-kitchen-dsc/) - not discussed, but, helpful if you dive deeper:
  * [In depth](https://gaelcolas.com/2016/07/11/introduction-to-kitchen-dsc/)
  * [Test-Kitchen DSC Quick Start](http://stevenmurawski.com/powershell/2016/05/getting-started-with-test-kitchen-and-dsc/index.html)
  * [Using Test Kitchen on AppVeyor](http://www.hurryupandwait.io/blog/run-kitchen-tests-in-travis-and-appveyor-using-the-kitchen-machine-driver)
* PSDeploy Things
  * [Repo](https://github.com/RamblingCookieMonster/PSDeploy)
  * [Docs](http://psdeploy.readthedocs.io)
  * [Blog 1](http://ramblingcookiemonster.github.io/PSDeploy/) - Note: uses deprecated yaml configs in examples
  * [Blog 2](http://ramblingcookiemonster.github.io/PSDeploy-Take-Two/) - On PSDeploy
  * [Blog 3](http://ramblingcookiemonster.github.io/PSDeploy-Inception/) - On deploying modules
  * [Building a Simple Release Pipeline in PowerShell Using psake, Pester, and PSDeploy](https://devblackops.io/building-a-simple-release-pipeline-in-powershell-using-psake-pester-and-psdeploy/)
* Release Pipeline related projects that we haven't linked already - Apologies for anything I forgot or overlooked!
  * [Plaster](https://github.com/PowerShell/Plaster)
  * [BuildHelpers](https://github.com/RamblingCookieMonster/BuildHelpers)
  * [Invoke-Build](https://github.com/nightroman/)Invoke-Build
  * [psake](https://github.com/psake/psake)
    * [psake walk through](https://speakerdeck.com/glennsarti/psake-good-for-more-than-just-sushi)
  * [PSSlack](https://github.com/RamblingCookieMonster/PSSlack) - [among](https://t.co/6AITjYiiBs) [others](https://t.co/DSbjvwc5J4)
  * [Lability](https://github.com/VirtualEngine/Lability)