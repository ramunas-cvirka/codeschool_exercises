# 4.2 Extract View Logic
class ItemDecorator
  attr_reader :item
  
  def initialize(item)
    @item = item
  end
  
  def is_featured?
    item.ratings > 5
  end
  
  def method_missing(m, *a, &b)
    item.send(m, *a, &b)
  end
  
  def respond_to_missing?(m, ip = false)
    item.respond_to?(m, ip) || super
  end
end

# 4.3 Decorators from Views
<h2><%= @item_decorator.title %></h2>

<% if @item_decorator.is_featured? %>
  <h3><%= featured_image %></h3>
<% end %>

<p><%= @item_decorator.description %></p>

# 4.4 Decorators from Controllers
class ItemsController < ApplicationController
  def index
    @items = ItemDecorator.build_collection(Item.all)
  end
end

# 4.5 Extract from View Helpers I
class ItemDecorator
  def initialize(item)
    @item = item
  end

  def status
    if @item.sold?
      "Sold at #{@item.sold_on.strftime('%A, %B %e')}"
    else
      "Available"
    end
  end  
  
  def method_missing(method_name, *args, &block)
    @item.send(method_name, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    @item.respond_to?(method_name, include_private) || super
  end
end

# 4.6 Extract from View Helpers II
<li>
  <%= @item_decorator.name %> <i><%= @item_decorator.status %></i>
</li>
