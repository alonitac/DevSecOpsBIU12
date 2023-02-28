## Git basics - practice it all together yourself

1. Create a new repository locally.
2. Create a new file, `add` it to the index and `commit` it.
3. Modify the file and commit your change.
4. Rename the file (either with `git mv` or `git add` + `git rm`), check your changes by `git status` before committing (to ensure the renaming is correctly handled).
5. Delete the file and commit the changes.
6. Create two new files and commit this change, modify their content in the working tree and display the changes with `git diff`.
7. Add one of the files into the index, keep the other one in the working tree only. Display the changes between:
    1. the index and the working tree
    2. the last commit (HEAD) and the index
    3. the last commit (HEAD) and the working tree
8. Reset the index **only**.
9. Reset the index and the working tree both.
