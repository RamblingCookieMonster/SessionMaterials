# Git and GitHub Demo

Notes from [presentation](https://www.meetup.com/PowerShell_Chattanooga/events/239845484/) - some may be leftover from a prior demo.

Original presentation and many git references [here](https://github.com/RamblingCookieMonster/Git-Presentation)

## EXPLORING GITHUB

### Front page

* What’s going on with your stuff
* What’s going on with people you follow and repos you watch

### Repository

* https://github.com/RamblingCookieMonster/Invoke-Parallel
* All the version control fun for a particular project
* You decide what goes in. A bunch of random powershell scripts? A module? A single script?
* The Readme provides a handy 'front page' for your project.
  * I like to include an overview, instructions, and examples at the very least.

### Issues

* Not Git. Part of GitHub or solutions like it (GitLab, VSTS, etc.)
* Great way to get started working on a project, even if you aren’t comfortable working with the code itself yet.
  * Feature requests
  * Bug reports
* Remember the golden rule. Would you want someone submitting an issue saying "it's broken?"
  * Provide details about what you're running, specific error messages, your environment, and other notes you would expect in a bug report.
* Larger or more organized repos often have a Contributing.md https://github.com/PowerShell/PowerShell/blob/master/.github/CONTRIBUTING.md
* Open issue > Notice it links to the Contributing doc, and includes a template

### Commit

* A point in time snapshot of an entire project. Central to Git.

### Fork

* Not part of Git
* ‘Copy someone else’s repository to my GitHub account!’
* Basically… clone, but to your GitHub account. Server side clone. Terminology specific to GitHub and other solutions (e.g. BitBucket, GitLab)
* Why? Collaboration and sharing. I can fork anyone’s repo and make my own modifications.
  * I can collaborate with the author and send my changes, or
  * just keep them in my own account (See RabbitMqTools example)
* We're going to fork Demo-To-Fork for later. All we do is click the fork button!
* https://github.com/DemoGitHubUser/Demo-To-Fork - You can do the same thing with the DSC Resources, community modules, or PowerShell itself!

### New Repository!

* Name - Demo
* Optional Description
* Add a license
  * Don't ignore this! Some folks won’t use your code or contribute to it if no license or a certain license.
  * For example, Microsoft and other employees might not contribute to a project under GPL.  I tend to choose MIT

### Clone

* ‘Copy a repository to this path!’
* Usually refers to a remote repo (e.g. on GitHub)
* Clone in Desktop button, if it's easier
* Note the clone URL. You'll need this if you clone with git.exe


## GitHub for Windows client

Assuming you've installed GitHub for Windows

  * Username and password for your GitHub account
  * Username and mail for commits
    * Public. To keep it private: username@users.noreply.github.com
  * This configures your gitconfig. For more info:
    * http://www.git-scm.com/book/en/v2/Customizing-Git-Git-Configuration
    * e.g. http://nickberardi.com/gitconfig/

Clone

* Let's clone our new repository
* + (Plus) > Clone > Pick a repo to clone
* Pick the Demo repo we created
* This is the same whether you are cloning your own repository, or a repository you forked.

You usually clone down the repository once. Let's walk through an example day-to-day workflow in the GitHub client.

* Add a file
* Notice the check box next to the file.
  * Long story short, need to know that there's
    * the working directory (file system you see),
    * a staging area (the check box),
    * and the repository itself (everything in change control).
  * Git only tracks changes you tell it to track via that the staging area. Checkbox is the GitHub clients' way of showing that stage.
    * We'll go into more detail when we look at the command line.
* Commit - You've decided you want to take a snapshot in time of your project. Something you can revert to or review in the future.
  * A clear, concise message is helpful. Add further details in the description
    * "Adding file_name"
  * This only affects your local repository! https://github.com/RamblingCookieMonster/Demo
* Make some minor changes in the file
* Notice the diff from GitHub. Very handy to see what changed!
* Commit the change - Minor help updates
* Notice the Sync button?
  * This basically says 'sync up this repository between my local and GitHub copies!'
  * First, it runs git pull --rebase to pull changes from GitHub to your local repo
  * Second, if there are local changes, it runs git push to send them to the GitHub repo
  * Now we can check GitHub and see that it is up to date!
  * If you work on multiple computers, you can hit the sync button if you get out of date from the GitHub repo, continue working
  * Hint: Try to keep your local copy up to date. Changing the same file from two places can lead to merge conflicts.
    * Typically trivial to fix for small PowerShell projects, outside the scope of this session.

Overall, this is a simple workflow!

* Make changes
* Commit
* Optionally sync to GitHub when appropriate
* Want to work locally, not worry about GitHub? git init creates a new repository.

## Using Git from the shell

* GitHub for Windows client includes msysgit, posh-git
* Some folks have worked on getting this into the ISE, I stick to powershell.exe still (http://virtualengine.co.uk/2015/git-and-the-powershell-ise/)
  * Windows 10 makes this a bit more pleasant to use. Try ConEmu for a handy shell alternative
* We're going to be using Git.exe. That means all the handy conventions and shared knowledge of PowerShell get thrown out the door. git --help
* Some folks from the virtual powershell user group, including Joel Bennett and Justin Rich, are working on PowerShell-izing git commands, and have a repository out on GitHub - https://github.com/PoshCode/PSGit

Let's run the same workflow as above.  Watch the prompt as we go. + is new ~ is change - is removed. Red means unstaged/untracked, green means staged

* Create a new file:

```powershell
New-Item .\Test.ps1
# Notice the red prompt. This is saying we have +1 new files
# For more info on the prompt, hit up https://github.com/dahlbyk/posh-git#the-prompt
git status
```

* Stage that file:

```powershell
Git add -A
# http://stackoverflow.com/questions/572549/difference-between-git-add-a-and-git-add Case sensitive...
# This says stage any changes I've made.
```

* Commit that file:

`git commit -m "added test.ps1"`

* Any updates from GitHub? Optionally run

`git pull --rebase`

* Push updates up to GitHub:

`git push`

### Exploring With Git

```
    # Ahead of time, cloned https://github.com/powershell/powershell, browsed to that dir

    # I removed something I need
    # can't remember a keyword
    # but I mentioned 'remove' in commit message!
        git log

        # Set up a quick alias for pretty output - git lg will now run git log....
        git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

        # Search commit messages for 'remove'
        git lg --all -i --grep='remove'

        # Search commit messages... and show diff
        git log --all -i --grep='remove' -p

    # I know something broke in the last 2 weeks...
    git lg --no-merges --raw --since='2 weeks ago'

    # So-and-so is working on something interesting.  Let's wee what they're doing!
    git lg --author=bruce

    # Which commits had content changed with regex 'envhome'?
    git log -G envhome -i -p

    # Look at who last touched each line:
    git blame ./src/Microsoft.PowerShell.Commands.Utility/commands/utility/sort-object.cs

    # I know I have something to do... search current codebase for todo!
    git grep -i 'todo'
```

### Branches!

* Think of each commit as a snapshot of your project. Similar to a VM snapshot.
* A branch is just a named pointer to one of these commits, like a post-it note.
* By default, when you create a new repository, git creates a 'master' branch, that nearly everyone uses.
* Basically like having an entire separate copy of your project, which you can work on without breaking other copies. Try a new feature that will break existing stuff. Create a new version of your project that breaks down level compatibility. Etc.
* Branches might seem complicated if you haven't worked with them before. Try the demo we're walking through at home, the interactive branching tutorial in the references for this presentation, or consider spending a few minutes with on chapter in the Pro Git book: http://git-scm.com/book/en/v1/Git-Branching-What-a-Branch-Is
* Obnoxious terminology time! Git also needs to know what you want to work on. This is called 'HEAD'. It's literally just a file that points to one of these branches! If you don't use any of this, you have a master branch and HEAD always points at it.

`get-content .\.git\HEAD`
`get-content .\.git\refs\heads\Dev`

* Let's give this a shot. It's much easier than it sounds.
* Clone Demo-To-Fork. Open explorer.
* We can flip back and forth. Important to note that this changes your working directory (file system)
* Look at existing branches (use -a to include remotes):

`git branch`

* Move HEAD to Dev branch. Working on MSFT DSC Resources? They want you to use Dev.

`git checkout Dev    # Case sensitive...`

* Let's add a new file, add some content to a file, commit

```powershell
New-Item "SomeDevCode.ps1"
"## Some major change!!" | Add-Content .\Get-Something.ps1
git add -A
git commit -m "added dev file, updated readme"
```

* Okay! now we have two branches, master and Dev. Let's move back and forth to illustrate
* Open explorer...

```
git checkout master
dir
git checkout Dev    # Case sensitive....
dir
```

* You won't need to do this for DSC resources, but no git presentation is complete without mentioning merge

        `git checkout master`
        `git merge Dev  # merges into the branch we're in.`

* Finally, let's send our changes back to GitHub. by default, it only pushes the current branch, so we do --all

        `git push --all`

* GitHub Windows client has a drop down for branches as well.

* We won't do it here, but it's simple to create a new branch
  * This creates a branch from wherever our HEAD is pointing:

```powershell
git branch CrazyTest
git checkout CrazyTest
new-item Crazy.ps1
git add -A
git commit -m "added crazy"
git push --all -u  # Push all branches, and set up upstream tracking for this new branch...
```

At this point, we're good to go! We've made some changes the the DSC resource, and we want to submit them up to Microsoft. Let's log onto GitHub and quickly run through that workflow.

## Collaboration

* Browse to our fork
* Click green 'Compare & pull request' button!

* Pick the branch we care about
  * Base = the original repo
  * Head fork = our changes
  * Make sure we're picking Dev!
  * Type in a friendly pull request message. Remember the golden rule - treat others as you would like to be treated - would you want someone asking to reformat the syntax in your project? Would you want a request changing 500 lines of code with no details on what changed?
* Create pull request. You can now chat with the author and others.

* While the pull request is open, we can keep making changes and pushing them as DemoGitHubUser. They get added to the pull request automatically.  Also, by default, the author of the repository you are contributing to will have access to make changes your fork/branch

Just to re-iterate the workflow:

* Fork someone elses repository
* Clone your fork to your desktop
* Make some changes
* Commit your changes
* Push to github
* Submit a pull request!

Log in as the author!

* Notifications
  * I can view changes, commits, and I can comment, maybe ask for minor changes. If I don't like it, I can close it out.
  * When I'm ready, I hit merge. Most use cases in the PowerShell world won't get much more complicated than this. If they do, google is your friend!

That's about it. I'd highly recommend getting involved with the PowerShell community on GitHub. Contribute to an existing project, or create your own project. Once you start using this you might start wishing you had something similar at work...

If you end up contributing to the DSC Resources or PowerShell repo, check out Microsoft's contribution guidelines

    Guide to getting started with GitHub (From MSFT): https://github.com/PowerShell/DscResources/blob/master/GettingStartedWithGitHub.md
    DSC Contributions guide: https://github.com/PowerShell/DscResources/blob/master/CONTRIBUTING.md
    DSC Resource Style Guidelines: https://github.com/PowerShell/DscResources/blob/master/StyleGuidelines.md
    PowerShell Contributions guide: https://github.com/PowerShell/PowerShell/blob/master/.github/CONTRIBUTING.md

## Misc / Common Questions

* Oh shoot! the repo you forked was updated on the author's end. How do we update?

```
# A bit of a pain: http://stackoverflow.com/questions/7244321/how-to-update-github-forked-repository or https://help.github.com/articles/syncing-a-fork/.  Many folks use rebase rather than merge.
git remote add upstream https://github.com/psCookieMonster/Demo-To-Fork.git # original repo you forked url
git fetch upstream
git checkout master
git merge upstream/master
```

* All my commits look so messy! Can I consolidate them down?
  * Danger zone. This is absolutely possible, and might be easy, but use caution.
  * Long story: Consider the logic here: http://justinhileman.info/article/git-pretty/git-pretty.png
  * Short story: If you haven't pushed to GitHub, consider git rebase -i
    * Example reference: https://help.github.com/articles/about-git-rebase/

