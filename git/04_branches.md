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
