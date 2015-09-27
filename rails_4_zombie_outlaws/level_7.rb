# ACTIONCONTROLLER::LIVE
class SightingsController < ApplicationController

  include ActionController::Live

  def alerts
    response.stream.write "Half-eaten brains found near saloon.\n\n"
    response.stream.write "Chickens disappear from farm.\n\n"
    response.stream.write "Zombie seen by Walker Ranch!\n\n"
    response.stream.close
  end

end

# EVENTSOURCE
class SightingsController < ApplicationController

  include ActionController::Live

  def alerts
    response.headers["Content-Type"] = "text/event-stream"
    response.stream.write "data: Half-eaten brains found near saloon.\n\n"
    response.stream.write "data: Chickens disappear from farm.\n\n"
    response.stream.write "data: Zombie seen by Walker Ranch!\n\n"
    response.stream.close
  end

end

# TURBOLINKS EVENTS
function initialize() {
  alert('Welcome, Deputy! Check back often for new zombie sightings!');
}

$(document).on('page:load', initialize);

# ALTERNATIVE EVENTS
$(document).on('click', '#alert_resolved', clickAlert);

# OTHER TURBOLINKS EVENTS
$(document).on('page:fetch', showLoading);
$(document).on('page:change', hideLoading);

# SELECTIVE DISABLING I
<p id="notice"><%= notice %></p>

<p>
  <strong>Name:</strong>
  <%= @zombie.name %>
</p>

<%= link_to 'Edit', edit_zombie_path(@zombie) %> |
<%= link_to 'Back', zombies_path %> | 
<%= link_to 'Home', welcome_path, 'data-no-turbolink' => true %>

# SELECTIVE DISABLING II
<div id="navigation" data-no-turbolink="true">
  <div><%= link_to 'Zombies', zombies_path %></div>
  <div><%= link_to 'Weapons', weapons_path %></div>
</div>
