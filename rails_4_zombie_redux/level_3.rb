# VIEWS SIMPLE
<h1><%= zombie.name %></h1>

<p>
  <%= zombie.graveyard %>
</p>

# LINKING
<p>
<%= link_to zombie.name, zombie %>
</p>

# EACH BLOCKS
<ul>
<% zombies.each do |z| %>
  <li><%= z.name %></li>
<% end %>
</ul>

# IF
<ul>
  <% zombies.each do |zombie| %>
    <li>
      <%= zombie.name %>
      <% if zombie.tweets.count > 1 %>
      <%= "SMART ZOMBIE" %>
      <% end %>
    </li>
  <% end %>
</ul>

# LINKING IN BLOCKS
<ul>
  <% zombies.each do |zombie| %>
    <li>
      <%= link_to zombie.name, edit_zombie_path(zombie) %>
    </li>
  <% end %>
</ul>
