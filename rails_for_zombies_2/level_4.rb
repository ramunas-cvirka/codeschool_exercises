# Generate Mailer
rails g mailer WeaponMailer low_ammo broken

# Simple Mailer
class WeaponMailer < ActionMailer::Base
  default from: "admin@rfz.com"

  def low_ammo(weapon, zombie)
    mail to: zombie.email, subject: "#{weapon.name} has low ammo"
  end
end

# Mail Delivery
class Weapon < ActiveRecord::Base
  belongs_to :zombie 

  before_save :check_ammo

  def check_ammo
    WeaponMailer.low_ammo(self, zombie).deliver if ammo == 3
  end
end

# Attaching a File
class WeaponMailer < ActionMailer::Base
  default from: "admin@rfz.com"

  def low_ammo(weapon, zombie)
    attachments['weapon.jpg'] = weapon.picture_file
    mail to: zombie.email, subject: "#{weapon.name} has low ammo"
  end 
end

# Asset Tags
<%= image_tag 'weapon.png' %>
<%= javascript_include_tag 'weapon' %>
<%= stylesheet_link_tag 'weapon' %>

# Asset Path
h2#newUser {
  text-indent: -9999px; 
    a {
    height: 64px;
    width: 50px;
    display: block;
    background: url(<%= asset_path('rails.png') %>) no-repeat;
  }
}

# Coffeescriptin
$(document).ready ->
  $('#displayWeaponForm').click (e) -> 
    e.preventDefault()
    $(this).hide()
    $('#newWeapon').show()

# Requiring Javascript
//= require jquery
//= require jquery_ujs 
//= require calendar
//= require color_picker
//= require_tree .