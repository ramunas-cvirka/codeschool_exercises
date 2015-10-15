# REBASE RECAP
git rebase master

# INTERACTIVE REBASE
git rebase -i HEAD~4

# COMMIT ORDERING
pick b3f1649 Add unicorn
pick 4b65a5a Add tests
pick f239187 Implement poodles
pick c3f863f Added a title to the homepage

# Rebase b3f1649..c3f863f onto b3f1649
#
# Commands:
#  p, pick = use commit
#  r, reword = use commit, but edit the commit message
#  e, edit = use commit, but stop for amending
#  s, squash = use commit, but meld into previous commit
#  f, fixup = like "squash", but discard this commit's log message
#  x, exec = run command (the rest of the line) using shell
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out

# REWORDING A COMMIT I
pick b3f1649 Add unicorn
reword 4b65a5a Add tests
pick f239187 Implement poodles
pick c3f863f Added a title to the homepage

# REWORDING A COMMIT II
Add tests for poodles

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
# Not currently on any branch.
# Changes to be committed:
#   (use "git reset HEAD^1 <file>..." to unstage)
#
#       new file:   poodle_spec.txt

# SPLIT COMMITS I
edit b3f1649 Add unicorn
pick 4b65a5a Added tests for poodles
pick f239187 Implement poodles
pick c3f863f Added a title to the homepage

# SPLIT COMMITS II
git reset HEAD^

# SPLIT COMMITS III
git rebase --continue

# SQUASHING COMMITS I
pick b3f1649 Add unicorn
pick 4b65a5a Add tests
pick f239187 Implement poodles
squash c3f863f Add title to poodle page

# SQUASHING COMMITS II
squashed some poodles
