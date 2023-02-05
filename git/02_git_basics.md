# Git Version control system

## First steps

1. The `git init myrepo` command creates a new clean repo locally.
2. List the repo files by `ls -la ./myrepo`, note the `myrepo/.git` directory in which git stores all revisions and metadata. Never delete it.
3. Create a new file in `myrepo` folder, and **commit** it:
```
cd myrepo
echo "Hello world" >> hello
git add hello
git commit -m “add hello”
```
4. It's highly recommended using `git status` if you don't know the state of your repo.
5. In the below example, Git complains because the **index** is unchanged (nothing to commit). We need to run `git add` to **stage** the file before it can be committed:
```text
$ echo 'bla bla' >> hello
$ git commit -m "another commit message"

On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
    modified:   hello

no changes added to commit (use "git add" and/or "git commit -a")
```
5. Let’s try to remove `hello` file by `rm` command and commit the change.
```shell
rm hello

# NOTE: since we commit changes, not files, delete files also has to be staged!!!
git add hello

# If you want to do the above two steps in one command: git rm hello
```

## Reset changes

6. How could we reset changes we did in our repository? `git reset`!
    1. `git reset` - resets the index **but not** the working tree
       ```shell
       echo "some content" >> file1
       git add file1
       git status  # does file1 in the staging area?
       git reset 
       git status
       cat file1  # file1 exists in the working tree!
       ```
    2. `git reset --hard` - resets the index **and** working tree
       ```shell
       echo "some content" >> file2
       git add file2
       git status  # does file2 in the staging area?
       git reset --hard
       git status
       cat file2  # file2 doesn't exist in the working tree!
       ```
    3. So far we’ve seen how to use `git reset` to reset changes in the index or in the working tree and the index **both**. How could we reset changes in the working tree **only**? There is a trick using git checkout command
       ```shell
       git checkout -- .
       ```
## Show differences

7. Show differences:
```shell
echo foo >> hello
git add hello
echo bar >> hello
git status
git diff

# diff --git a/hello b/hello
# index 1b7c0bf..3bdbab2 100644
# --- a/hello
# +++ b/hello
# @@ -1,2 +1,3 @@
#  bla bla bla1
#  foo
# +bar

git diff --staged

# diff --git a/hello b/hello
# index 6b6f48d..1b7c0bf 100644
# --- a/hello
# +++ b/hello
# @@ -1 +1,2 @@
#  bla bla bla1
# +foo

git diff HEAD

# diff --git a/hello b/hello
# index 6b6f48d..3bdbab2 100644
# --- a/hello
# +++ b/hello
# @@ -1 +1,3 @@
#  bla bla bla1
# +foo
# +bar

```

## Tagging

8. Create a lightweight tag by `git tag v1.4-stable`
9. List all git tags by `git tag`
10. Display the tag details by `git show v1.4-stable`
11. Create an annotated tag by `git tag -a v1.5 -m "version 1.5 tagging"`

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

