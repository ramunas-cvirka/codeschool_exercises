# 5.2 Creating a versioned namespace
SurvivingRails::Application.routes.draw do
  namespace :v1 do
  	resources :zombies
  end
  
  namespace :v2 do
    resources :zombies, except: :destroy
  end
end

# 5.3 Testing Routes For URI Versioning
class RoutesTest < ActionDispatch::IntegrationTest
  test 'routes to proper versions' do
    assert_generates '/v1/zombies', { controller: 'v1/zombies', action: 'index' }
    assert_generates '/v2/zombies', { controller: 'v2/zombies', action: 'index' }
  end
end

# 5.4 Rendering Zombies
module V1
  class ZombiesController < ApplicationController
    def index
      zombies = Zombie.all
      render json: zombies, status: 200
    end
  end
end

# 5.5 Testing Setting The REMOTE_ADDR Header
class ZombiesWithIpTest < ActionDispatch::IntegrationTest
  setup { @ip = '192.168.1.12' }

  test '/v1 returns ip and v1' do
    get '/v1/zombies', {}, { 'REMOTE_ADDR' => @ip }
    assert_equal 200, response.status
    assert_equal "#{@ip} and version one", response.body
  end

  test '/v2 returns ip and v2' do
    get '/v2/zombies', {}, { 'REMOTE_ADDR' => @ip }
    assert_equal 200, response.status
    assert_equal "#{@ip} and version two", response.body
  end
end

# 5.6 Using before_action To Set The IP
##--- application_controller.rb
class ApplicationController < ActionController::Base
  before_action ->{ @user_ip = request.headers['REMOTE_ADDR'] }
end
##--- v1/zombies_controller.rb
module V1
  class ZombiesController < ApplicationController
    def index
      render json: "#{@user_ip} and version one", status: 200
    end
  end
end
##--- v1/zombies_controller.rb
module V2
  class ZombiesController < ApplicationController
    def index
      render json: "#{@user_ip} and version two", status: 200
    end
  end
end
##--- zombies_with_ip_test.rb
require 'test_helper'

class ZombiesWithIpTest < ActionDispatch::IntegrationTest
  setup { @ip = '192.168.1.12' }

  test '/v1 returns ip and v1' do
    get '/v1/zombies', {}, { 'REMOTE_ADDR' => @ip }
    assert_equal 200, response.status
    assert_equal "#{@ip} and version one", response.body
  end

  test '/v2 returns ip and v2' do
    get '/v2/zombies', {}, { 'REMOTE_ADDR' => @ip }
    assert_equal 200, response.status
    assert_equal "#{@ip} and version two", response.body
  end
end

# 5.7 Extracting Duplicate Code
##--- version_controller.rb
module V2
  class VersionController < ApplicationController
    abstract!
    before_action -> { log_survival_request }
  end
end
##--- v2/humans_controller.rb
 module V2
   class HumansController < VersionController
    def index
      humans = Human.all
      render json: humans, status: 200
    end
  end
end
##--- v2/zombies_controller.rb
module V2
  class ZombiesController < VersionController
    def index
      zombies = Zombie.all
      render json: zombies, status: 200
    end
  end
end
# 5.8 Using the Accept Header
class ListingZombiesTest < ActionDispatch::IntegrationTest
  test 'show zombie from API version 1' do
    get '/zombies/1', {}, { 'Accept' => 'application/vnd.zombies.v1+json' }
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    msg = json(response.body)
    assert_equal 'This is version one', msg[:message]
  end
end

# 5.10 Api Version Route Constraint
class ApiVersion

  def initialize(version, default_version = false)
    @version, @default_version = version, default_version
  end

  def matches?(request)
    @default_version || check_headers(request.headers)
  end

  private
    def check_headers(headers)
      accept = headers['Accept'] 
      accept && accept.include?("application/vnd.zombies.#{@version}+json")
    end
end

# 5.11 Route Version Constraint
SurvivingRails::Application.routes.draw do
  require 'api_version'
  scope defaults: { format: 'json' } do
    scope module: :v1, constraints: ApiVersion.new('v1') do # Task 2
      resources :zombies
    end
    scope module: :v2, constraints: ApiVersion.new('v2', true) do # Task 3
      resources :zombies
    end
  end
end

# 5.12 Default Version Test
class RoutesTest < ActionDispatch::IntegrationTest
  test 'defaults to v2' do
    assert_generates '/zombies', { controller: 'v2/zombies', action: 'index' }
  end
end
