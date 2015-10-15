# GIT STASH
git stash save

# GIT STASH LIST
git stash list

# GIT STASH APPLY
git stash apply

# GIT STASH DROP
git stash drop

# CONFLICTS I
git stash apply

# CONFLICTS II
git reset --hard HEAD

# GIT STASH POP
git stash pop

# KEEPING THE INDEX
git stash --keep-index

# INCLUDE UNTRACKED
git stash --include-untracked

# LIST OPTIONS
git stash list --stat

# STASH DETAILS
git stash show --patch stash@{2}

# STASH MESSAGE
git stash save 'Added groom method'

# STASH BRANCHING
git stash branch poodle stash@{0}
