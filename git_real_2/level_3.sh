# REPO COPY
git clone poodles poodles_bu

# TREE FILTER
git filter-branch --tree-filter 'rm -f master_password.txt' -- --all

# INDEX FILTER
git filter-branch --index-filter 'git rm --cached --ignore-unmatch master_password.txt'

# FORCE
git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch master_username.txt'

# PRUNING
git filter-branch -f --prune-empty -- --all
