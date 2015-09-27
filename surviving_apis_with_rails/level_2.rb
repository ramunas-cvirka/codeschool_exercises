# 2.2 Integration Intro
class ListingHumansTest < ActionDispatch::IntegrationTest
  setup { host! 'api.example.com' }

  test 'returns a list of humans' do
    get '/humans'
    assert_equal 200, response.status
    refute_empty response.body
  end
end

# 2.3 Listing Resources
module API
  class HumansController < ApplicationController
    def index
      humans = Human.all

      render json: humans, status: :ok
    end
  end
end

# 2.4 Test Listing Resources With Query Strings
class ListingHumansTest < ActionDispatch::IntegrationTest
  setup { host! 'api.example.com' }
  allan = Human.create!(name: 'Allan', brain_type: 'large')
  john = Human.create!(name: 'John', brain_type: 'small')

  test 'returns a list of humans by brain type' do
    get '/humans?brain_type=small'
    assert_equal 200, response.status
    humans = JSON.parse(response.body, symbolize_names: true)
    names = humans.collect { |h| h[:name] }
    assert_includes names, 'John'
    refute_includes names, 'Allan'
  end
end

# 2.5 Resources With Filter
module API
  class HumansController < ApplicationController
    def index
      humans = Human.all

      if bt = params[:brain_type]
        humans = humans.where(brain_type: bt)
      end
      render json: humans, status: :ok
    end
  end
end

# 2.6 Test Retrieving Data For One Human
class ListingHumansTest < ActionDispatch::IntegrationTest
  setup { host! 'api.example.com' }

  test 'returns human by id' do
    ash = Human.create!(name: 'Ash')
    get "/humans/#{ash.id}"
    assert_equal 200, response.status
    human_res = json(response.body)
    # only passes with 'actual','expected' order
    assert_equal human_res[:name], ash.name
  end
end

# 2.7 Returning One Human
module API
  class HumansController < ApplicationController
    def show
      human = Human.find(params[:id])
      render json: human, status: :ok
    end
  end
end

# 2.8 Using curl to Issue Network Requests
$ curl http://cs-zombies-dev.com:3000/humans

# 2.9 Curl With Query Strings
$ curl http://cs-zombies-dev.com:3000/humans?brain_type=large

# 2.10 Displaying Response Headers
$ curl -I http://cs-zombies-dev.com:3000/humans