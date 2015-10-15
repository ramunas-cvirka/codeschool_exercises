# SUBMODULE
git submodule add git@petstore.com:gallery_js.git

# STAGING A SUBMODULE
git add -A

# COMMITTING A SUBMODULE
git commit -m 'bla'

# INIT SUBMODULE
git submodule init

# UPDATE SUBMODULES
git submodule update

# DETACHED HEAD
git branch temp_changes a7eded4

# BRANCH MERGE
git merge temp_changes

# PUSH CHECK
git push --recurse-submodules=check

# ON DEMAND PUSH
git push --recurse-submodules=on-demand

# ON DEMAND ALIAS
git config --global alias.pa 'push --recurse-submodules=on-demand'
