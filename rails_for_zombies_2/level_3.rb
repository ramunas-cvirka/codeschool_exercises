# Routes be Rakin
rake routes

# Forms
<h1>New tweet</h1>
<%= form_for(@tweet) do |f| %>
  <%= f.text_area :status %>
  <%= f.text_field :location %>
  <%= f.submit %>
<% end %>

# Inputs
<%= form_for(@weapon) do |f| %>
  <%= f.text_field :name %>
  <%= f.number_field :ammo %>
  <%= f.check_box :is_broken %>
  <%= f.submit %>
<% end %>


# Radio Button
<%= form_for(@weapon) do |f| %>
  <%= f.text_field :name %>
  <%= f.number_field :ammo %>
  <%= f.radio_button :condition, 'New', checked: true %>
  <%= f.radio_button :condition, 'Rusty' %>
  <%= f.radio_button :condition, 'Broken' %>
  <%= f.submit %>
<% end %>

# Select Box
<%= form_for(@weapon) do |f| %>
  <%= f.select :condition, ['New', 'Rusty', 'Broken'] %>
<% end %>

# Nested Route
RailsForZombies::Application.routes.draw do
  resources :zombies do
    resources :tweets
    resources :weapons
  end
end

# Nested Params
class WeaponsController < ApplicationController
  def show 
    @zombie = Zombie.find(params[:zombie_id])
    @weapon = @zombie.weapons.find(params[:id])
  end
end

# Link To
<h2><%= @zombie.name %>'s weapons</h2>
<ul>
  <% @weapons.each do |w| %>
    <li><%= link_to w.name, zombie_weapon_path(@zombie, w) %></li>
  <% end %>
</ul>

<%= link_to "New Weapon", new_zombie_weapon_path(@zombie) %>

# Nested Form
<%= form_for [@zombie, @weapon] do |f| %>
  <%= f.text_field :name %>

  <%= f.submit %>
<% end %>

# Useful View Helpers
<h2><%= @zombie.name.titleize %></h2>
<p>Weapons: <%= @zombie.weapon_list.to_sentence %></p>
<p><%= pluralize(@zombie.tweets.size, 'Tweet') %></p>
<p>Money in Pocket <%= number_to_currency(@zombie.money) %></p>

# Form Partial
##--- new.html.erb
<h2>New Tweet</h2>

<%= render 'form' %>

<%= link_to 'back', tweets_path %>

##--- _form.html.erb
<%= form_for(@tweet) do |f| %> 
  <div class="field">
    <%= f.label :status %><br />
    <%= f.text_area :status %>
  </div>

  <div class="field">
    <%= f.label :location %><br />
    <%= f.text_field :location %>
  </div>

  <%= f.submit %>
<% end %>

# Partial Collection
##--- weapons/index.html.erb
<h1><%= @zombie.name %>'s Weapons</h1>
<%= render 'weapon' %>

##--- weapons/_weapon.html.erb
<% @weapons.each do |weapon| %> 
  <%= div_for weapon do %>
    <h2><%= weapon.name %></h2> 
    <p>
      Condition: <%= weapon.condition %>
      Ammo: <%= weapon.ammo %>
      Purchased <%= time_ago_in_words weapon.purchased_on %> ago
    </p> 
  <% end %>
<% end %>

