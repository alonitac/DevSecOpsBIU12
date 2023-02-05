# Git Version control system

## Working with branches

12. First, check your repo status by `git status`
13. Create a new `dev` branch by `git checkout -b dev`
14. `git status`
15. Switch from branch `dev` to `main` by `git checkout main`
16. Switch back to `dev` by `git checkout dev`
17. Let's make some changes in branch `dev`
```shell
echo "hello dev" >> hello.dev
git add hello.dev
git commit -m "first commit in branch dev"
```
18. We would like now to merge our changes from branch `dev` into `main`. In order to do so, you must go to the branch **into which you want to merge the changes**.
```shell
git checkout main
git merge dev  # merges dev branch into the current branch (main)
```
19. `git branch` command can help you to list, create and delete branches. (`--help` for more information...)

## Resolve conflicts

Now let's see how to create and resolve conflicts in Git.

20. `git status` and make sure you are on branch `main`.
21. Checkout, or create a new branch `dev`.
22. Create, add and commit file3 (it can be an empty file)
23. Create, add and commit file2 as follows:
```shell
echo "aaa" > file2
git add file2
git commit -m "add file2"
```
24. Now checkout `main` and create a conflict with `file2`:
```shell
git checkout main
echo "bbb" > file2
git add file2
git commit -m "add file2 in branch main"
```
Can you see got `file2` is conflicted between branch `dev` and `main`?
25. Add another file in `main`:
```shell
touch file1
git add file1
git commit -m "add file1 in branch main"
```
26. Checkout to branch `dev` and merge `main` into `dev`. Expect a conflict.
```shell
git checkout dev
git merge main
```
27. Use `git status` to inspect the working tree and the index.
28. Use your preferred text editor to resolve the conflict in `file2`. If you want the version of `main` for `file2`, the result should be:
```shell
bbb
```
29. Add the resolved file by `git add file2`
30. Commit the merge by `git commit -m "merge main into dev"`

## Breaking .git internal storage

Git stores commits objects under `.git/objects`. Try to break Git graph by changing some objects file names.
To verify the object you can use this simply command:
```shell
git fsck --full
```

Read more on the `fsck` command [here](https://git-scm.com/docs/git-fsck).

## Connect a local repo to remote

1. Let's [create an empty repository](https://docs.github.com/en/get-started/quickstart/create-a-repo#create-a-repository) in GitHub.
2. Add the created repo SSH url as remote in your local repository:
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

## Fork a remote repo and add `upstream`

1. From GitHub, fork our [shared repo](https://github.com/alonitac/DevSecOpsBIU11.git).
2. Clone it locally (using PyCharm is preferred).
3. Add the original repo (a.k.a. `upstream`) as a remote by:
```shell
git remote add upstream https://github.com/alonitac/DevSecOpsBIU11.git
```

