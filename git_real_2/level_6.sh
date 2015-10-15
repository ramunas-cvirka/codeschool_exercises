# THE MISTAKE
git reset --hard ab27026

# REFLOG
git reflog

# RESETTING THE REFLOG
git reset --hard HEAD@{1}

# DELETING A BRANCH
git branch -D fluffy_poodle

# WALKING REFLOGS
git log --walk-reflogs

# BRANCH RECOVERY
git branch fluffy_poodle HEAD@{1}
