# Git Version control system

## Connect a local repo to remote

1. Let's [create an empty repository](https://docs.github.com/en/get-started/quickstart/create-a-repo#create-a-repository) in GitHub.
2. Add the created repo **SSH url** as remote in your local repository:
```
git remote add origin git@github.com:<github-username>/<repo-name>.git
```
Note: you can add multiple remotes, just choose name other than `origin`. We will later see where multiple remotes can be useful.

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

## Fork a remote repo and add `upstream` another remote

1. From GitHub, fork our [shared repo](https://github.com/alonitac/DevSecOpsBIU12.git).
2. Clone it locally (using PyCharm is preferred).
3. Add the original repo (a.k.a. `upstream`) as a remote by:
```shell
git remote add upstream https://github.com/alonitac/DevSecOpsBIU12.git
```

4. You can now decide where would you like to push your changes, wither to `origin` remote, or `upstream`. 

