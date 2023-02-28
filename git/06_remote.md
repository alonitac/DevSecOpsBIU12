# Git Version control system


## Connect a local repo to remote

1. Let's [create an empty repository](https://docs.github.com/en/get-started/quickstart/create-a-repo#create-a-repository) in GitHub.
2. Add the created repo **SSH url** as remote in your local repository:
```
git remote add origin git@github.com:<github-username>/<repo-name>.git
```
Note: you can add multiple remotes, just choose a name other than `origin`. We will later see where multiple remotes can be useful.

3. Try to push your changes into GitHub by `git push -u origin master` and expect a `Permission denied (publickey)` error.
   In order to be able to communicate with GitHub, an SSH key pair (public and private) is needed:
    1. Generate a pair by `ssh-keygen -t ed25519 -C "your_email@example.com"`. Make sure your keys are stored in a safe place.
    2. Put your **public key** in GitHub (see [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) how)
    3. Configure git to use your private key as an identity:
       ```shell
       git config core.sshCommand 'ssh -i /path/to/private_key_file'
       ```
4. Push again your changes to remote by:
```shell
git push -u origin main
``` 

## Pull request

A pull request is the standard way to review and approve changes before they are merged into the production branch.
This process helps ensure that only high-quality, well-tested code is deployed to the production environment.

Here's a high-level overview of the steps involved in this process:

1. Developer creates a feature branch from an up-to-date version of `main` branch. The main branch represents production environment. In the feature branch she can make changes and test the code.

2. Developer pushes changes to the feature branch (either GitHub, or GitLab, BitBucket etc...).

3. The developer opens a pull request from the feature branch to the production branch, `main`. This pull request acts as a request for someone in the team to review changes.

4. Review and feedback: The reviewer(s) reviews the changes and provides feedback to the developer. If necessary, the developer can make additional changes and update the pull request.

5. Merge and deployment: Once the changes have been reviewed and approved, the developer merges the changes into `main` branch. The updated production branch can then be deployed to the production environment.

### Do it yourself

1. In your created GitHub repo, add a [protection rule](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pull-requests/managing-a-branch-protection-rule#creating-a-branch-protection-rule) for branch `main` so no one can push changes directly to `main`.
2. Locally, create a feature branch called `my_feature` from branch `main`.
3. Commit come changes and push the commit to GitHub.
4. In GitHub website, create a pull request from `my_feature` into `main`.
5. Merge the PR. 

## Fork a remote repo and add `upstream` another remote

1. From GitHub, fork our [shared repo](https://github.com/alonitac/DevSecOpsBIU12.git).
2. Clone it locally (using PyCharm is preferred).
3. Add the original repo (a.k.a. `upstream`) as a remote by:
```shell
git remote add upstream https://github.com/alonitac/DevSecOpsBIU12.git
```

4. You can now decide where would you like to push your changes, wither to `origin` remote, or `upstream`. 

