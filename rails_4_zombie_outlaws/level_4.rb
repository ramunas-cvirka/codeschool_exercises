# COLLECTION FORM HELPERS I
<%= form_for(@limb) do |f| %>
  <div class="field">
    <%= f.label :zombie %><br />
    <%= collection_radio_buttons(:limb, :zombie_id, @zombies, :id, :name) %>
  </div>
<% end %>

# COLLECTION FORM HELPERS II
<%= form_for(@zombie) do |f| %>
  <div class="field">
    <%= f.label :limbs %><br />
    <%= collection_check_boxes(:limb, :id, @limbs, :id, :kind) %> 
  </div>
<% end %>

# DATES
<%= form_for(@limb) do |f| %>
  <div class="field">
    <%= f.date_field :date_found %>
  </div>
<% end %>

# RUBY TEMPLATE HANDLER
limbs_hashes = @limbs.map do |limb|
  { owner_name: limb.zombie.name, kind: limb.kind }
end

limbs_hashes.to_json

