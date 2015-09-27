# DYNAMIC FINDERS I
Zombie.where(weapon: 'Chainsaw')

# FIND BY I
Zombie.find_by(name: 'Ash')

# FIND BY II
Zombie.find_by(name: 'Ash', weapon: 'Chainsaw')

# FIND_OR_CREATE_BY
class MostWantedController < ApplicationController
  def create
    @zombie = Zombie.find_or_create_by(name: params[:name])
    redirect_to @zombie
  end
end

# UPDATE
@zombie.update(@zombie_params)

# MODEL.ALL
class MostWantedController < ApplicationController
  def index
    @zombies = Zombie.all
    if params[:outlaws]
      @zombies = @zombies.outlaws
    end
  end
end

# SCOPES
class Zombie < ActiveRecord::Base
  scope :recent, -> { where('killed_on > ?', 2.days.ago) }
  scope :outlaws, -> { where(status: 'outlaw') }
end

# MODEL.NONE
class Deputy < ActiveRecord::Base
  def self.zombie_counterforce
    if Zombie.at_large_count.zero?
      Deputy.none
    else
      Deputy.where(status: 'available')
    end
  end
end

# RELATION#NOT
Zombie.where.not(status: 'outlaw')

# RELATION#ORDER
Zombie.order(name: :desc, killed_on: :desc)

# RELATION#REFERENCES I
Weapon.includes(:zombies)
.where("zombies.name = 'Ash'").references(:zombies)

# RELATION#REFERENCES II
Weapon.includes(:zombies).where('zombies.name' => 'Ash')

