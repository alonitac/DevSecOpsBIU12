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
