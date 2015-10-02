# UNSTAGED DIFFERENCES
git diff

# STAGE NEW FILE
git add ostrich.html

# STAGED DIFFERENCES
git diff --staged

# UNSTAGE FILES
git reset ostrich.html

# SKIP STAGING
git commit -a -m 'bla'

# ADD TO COMMIT I
git add cats.html

# ADD TO COMMIT II
git commit --amend -m 'bla'

# ROLL BACK COMMIT
git reset --soft HEAD^

# DISCARD CHANGES
git checkout -- cats.html index.html

# REMOVE COMMIT I
git commit -a -m 'bla'

# REMOVE COMMIT II
git reset --hard HEAD^

# NEW REMOTE REPOS
git remote add origin git@example.com:example/petshop.git

# PUSH TO A REMOTE
git push -u origin master
