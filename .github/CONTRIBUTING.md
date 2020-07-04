# Contributing to This project

1. [Getting Involved](#getting-involved)
2. [How To Report Bugs](#how-to-report-bugs)
3. [Tips For Submitting Code](#tips-for-submitting-code)


## Getting Involved

There are a number of ways to get involved with this project. Even if you've never contributed code to an Open Source project before, we're always looking for help identifying bugs, cleaning up code, writing documentation and testing.

The goal of this guide is to provide the best way to contribute. 
Please read through the full guide detailing [How to Report Bugs](#how-to-report-bugs).

## Discussion

If you think you've found a bug please [file it in the bug tracker](#how-to-report-bugs).

## How to Report Bugs

### Make sure it is a bug related to this project

The best way is to start a new powershell prompt.

### Check if you have the latest version

We always make our tests based on the latest versions of the script.

If it isn't up-to-date, try to update it before sending a bug repport.

### Reporting the issue

If the above steps are failing and you are sure its a bug, issues are tracked in the [issue tracker](https://github.com/tunisiano187/chocolatey-ps-validator/issues).

## Tips For Submitting Code

### Before going deeper, check if it's not already repported

As this script is shared on Git, another user may already have seen the error and created a report.
Managing twice the same report can make us to loose time in solving the problem.

#### If the issue is already opened

If you find an issue with the same problem, you can subscribe to notifications or send complements.
If the explaination of the creator of the issue isn't complete, don't hesitate to add what you can. It may help us to find the solution quicker.

### Code

Every developper can help us enhance this script, i'm still managing the Pull requests and i'll check them all.

#### Reporting

Please follow these guidelines before reporting a bug:

1. **Update to the latest version** Check if you can reproduce the issue with the latest version.

2. **Use the search on this repo** check if the issue has already been reported. If it has been, please comment on the existing issue.

3. **Provide a means to reproduce the problem** Please provide as much details as possible, and of course the steps to reproduce the problem.

### Pull requests

[Pull requests](https://help.github.com/articles/using-pull-requests) are welcome and the preferred way of accepting code contributions.

Please follow these guidelines before sending a pull request:

1. Update your fork to the latest upstream version.

2. Create a topic-branch for your work. We prefer clear topics that are explaining the updates.

3. Keep your commits as autonomous as possible, i.e. create a new commit for every single bug fix or feature added.

4. Always add meaningful commit messages. We should not have to guess at what your code is supposed to do.

5. One pull request per feature. If you want multiple features, send multiple PR's

Please follow this process; it's the best way to get your work included in the project:

- [Fork](http://help.github.com/fork-a-repo/) the project, clone your fork,
   and configure the remotes:

```bash
   # clone your fork of the repo into the current directory in terminal
   git clone git@github.com:<your username>/chocolatey-ps-validator.git
   # navigate to the newly cloned directory
   cd chocolatey-ps-validator
   # assign the original repo to a remote called "upstream"
   git remote add upstream https://github.com/tunisiano187/chocolatey-ps-validator.git
   ```

- If you cloned a while ago, get the latest changes from upstream:

   ```bash
   # fetch upstream changes
   git fetch upstream
   # make sure you are on your 'master' branch
   git checkout master
   # merge upstream changes
   git merge upstream/master
   ```

- Make sure that your branch is up to date:

   ```bash
   # Switch to the master branch
   git checkout master
   # Pull down any updates
   git pull
   ```

- Create a new topic branch to contain your feature, change, or fix:

   ```bash
   git checkout -b <topic-branch-name> master
   ```

- Commit your changes in logical chunks. or your pull request is unlikely
   be merged into the main project. Use git's
   [interactive rebase](https://help.github.com/articles/interactive-rebase)
   feature to tidy up your commits before making them public.

- Push your topic branch up to your fork:

   ```bash
   git push origin <topic-branch-name>
   ```

- [Open a Pull Request](https://help.github.com/articles/using-pull-requests) with a
    clear title and description.


## Code guidelines

I currently haven't set standarts for coding, but i'll try to add them as soon as they exists...