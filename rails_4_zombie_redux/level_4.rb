# SHOW ACTION
class ZombiesController < ApplicationController
  def show
    @zombie = Zombie.find params[:id]
  end
end

# RESPOND TO
class ZombiesController < ApplicationController
  def show
    @zombie = Zombie.find(params[:id])

    respond_to do |format|
      format.xml { render xml: @zombie }
    end
  end
end

# CONTROLLER CREATE ACTION
class ZombiesController < ApplicationController
  def create
    @zombie = Zombie.create(zombie_params)
    redirect_to(zombie_path(@zombie))
  end

  private

  def zombie_params
    params.require(:zombie).permit(:name, :graveyard)
  end
end

# CONTROLLER BEFORE ACTION
class ZombiesController < ApplicationController
  before_action :find_zombie
  before_action :has_tweets?, :only => :show

  def has_tweets?
    @tweets = @zombie.tweets.all
  end
  
  def show
  	if @tweets.size == 0
  		redirect_to zombies_path
  	else
      render action: :show
    end
  end

  def find_zombie
    @zombie = Zombie.find params[:id]
  end
end
