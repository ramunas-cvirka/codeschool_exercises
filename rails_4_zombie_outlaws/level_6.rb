# FRESH_WHEN
class MostWantedController < ApplicationController
  def show
    @zombie = Zombie.most_wanted
    fresh_when(@zombie)
  end
end

# DECLARATIVE ETAGS I
class MostWantedController < ApplicationController
  etag {current_user.country}
  
  def show
    @zombie = Zombie.most_wanted
    fresh_when(@zombie)
  end

  def edit
    @zombie = Zombie.most_wanted
    fresh_when(@zombie)
  end
end

# DECLARATIVE ETAGS II
class MostWantedController < ApplicationController

  etag { current_user.country }
  etag { current_user.city }

  def show
    @zombie = Zombie.most_wanted
    fresh_when(@zombie)
  end

  def edit
    @zombie = Zombie.most_wanted
    fresh_when(@zombie)
  end
end

# FRAGMENT CACHING I
<% cache zombie do %>
	<li><%= zombie %></li>
<% end %>

# FRAGMENT CACHING II
class Zombie < ActiveRecord::Base
  belongs_to :weapon, touch: true
end

# CACHE DIGESTS I
<% cache @weapon do %>
  <section>
    <h3><%= @weapon.name %></h3>
    <ul>
      <%= render @weapon.zombies %>
    </ul>
    <%= link_to 'Details', @weapon %>
  </section>
<% end %>

# CACHE DIGESTS II
<% cache @weapon do %>
  <section>
    <h3><%= @weapon.name %></h3>
    <ul>
      <%= render partial: 'zombies/zombie', collection: @weapon.zombies.recent %>
    </ul>
    <%= link_to 'Details', @weapon %>
  </section>
<% end %>