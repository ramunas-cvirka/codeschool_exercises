# Rails New
rails new ZombieTweets

# Generate Scaffold
rails g scaffold tweet status:string zombie_id:integer

# Create Tweets Table
class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :status
      t.integer :zombie_id
    end
  end
end

# Run Migration
rake db:migrate

# Boot it up
rails s

# Add Column to Table
rails g migration AddPrivacyToTweets private:boolean

# Create Migration by Hand
class AddLocationToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :location, :string, limit: 30
    add_column :tweets, :show_location, :boolean, default: false
  end
end

# Rollback Migration
rake db:rollback

# Change Table
class AddLocationToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :location, :string, limit: 30
    add_column :tweets, :show_location, :boolean, default: false
    add_column :tweets, :category_name, :string
    rename_column :tweets, :status, :message
  end 
end

# Remove Column
class RemoveCategoryNameFromTweets < ActiveRecord::Migration
	# up migration
  def up
    remove_column :tweets, :category_name
  end

  # down migration
  def down
    add_column :tweets, :category_name, :string
  end
end

# Database Setup
rake db:setup

# In the Console
rails c