# CREATE MODEL
class Zombie < ActiveRecord::Base
end

# VALIDATIONS I
class Zombie < ActiveRecord::Base
  validates :name, presence: true
end

# VALIDATIONS II
class Zombie < ActiveRecord::Base
  validates :name, uniqueness: true
end

# VALIDATIONS III
class Zombie < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
end

# BELONGS TO
class Weapon < ActiveRecord::Base
  belongs_to :zombie
end

# RELATIONSHIP FIND
$ Zombie.find(1).weapons
