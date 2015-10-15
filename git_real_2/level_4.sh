# LINE ENDINGS I
git config --global core.autocrlf input

# LINE ENDINGS II
git config --global core.autocrlf true

# LINE ENDINGS III
*     text=auto
*.rb text
*.js text

*.bat text eol=crlf
*.sh text eol=lf

*.png binary

# CHERRY PICKING
git cherry-pick 3fbd473

# EDIT A CHERRY PICK
git cherry-pick --edit 3fbd473

# CHERRY PICK SQUASH I
git cherry-pick --no-commit b447335 b59d285

# CHERRY PICK SQUASH II
git commit -m 'bla'

# TRACKING CHERRY PICKS
git cherry-pick -x bdf9578

# SIGNING OFF
git cherry-pick --signoff bdf9578
