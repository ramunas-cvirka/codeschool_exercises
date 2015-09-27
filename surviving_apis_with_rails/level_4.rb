# 4.2 Integration Tests for POST
class CreatingHumansTest < ActionDispatch::IntegrationTest
  test 'creates human' do
    post '/humans', { human: { name: 'John', brain_type: 'small' } }.to_json, { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
    assert_equal 201, response.status
  end
end

# 4.3 Better Assertions
class CreatingHumansTest < ActionDispatch::IntegrationTest
  test 'creates human' do
    post '/humans', { human: { name: 'John', brain_type: 'small' } }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    human = json(response.body)
    assert_equal human_url(human[:id]), response.location
  end
end

# 4.4 Responding to a Successful POST Request
class HumansController < ApplicationController
  def create
    human = Human.new(human_params)
    if human.save
      render json: human, status: 201, location: human
    end
  end

  private

  def human_params
    params.require(:human).permit(:name, :brain_type)
  end
end

# 4.5 Forgery Protection
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
end

# 4.6 Posting Data With curl
$ curl -i -X POST -d 'human[name]=Ash' http://cs-zombies-dev.com:3000/humans

# 4.7 Post Method
class HumansController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    human = Human.new(human_params)

    if human.save
      render nothing: true, status: 204, location: human
    end
  end

  private

  def human_params
    params.require(:human).permit(:name, :brain_type)
  end
end

# 4.8 Using Head For Headers-Only Response
class HumansController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    human = Human.new(human_params)

    if human.save
      head 204, location: human
    end
  end

  private

  def human_params
    params.require(:human).permit(:name, :brain_type)
  end
end

# 4.9 Testing Unsuccessful Post Requests
class CreatingHumansTest < ActionDispatch::IntegrationTest
  test 'does not create human with name nil' do
    post '/humans',
      { human:
        { name: nil, brain_type: 'large' }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end
end

# 4.10 Responding To Unsuccessful Post Requests
class HumansController < ApplicationController
  def create
    human = Human.new(human_params)

    if human.save
      head 204, location: human
    else
      render json: human.errors, status: 422
    end
  end

  private

  def human_params
    params.require(:human).permit(:name, :brain_type)
  end
end

# 4.12 Integration Tests With Patch
class UpdatingHumansTest < ActionDispatch::IntegrationTest
  setup { @human = Human.create!(name: 'Robert', brain_type: 'small') }

  test 'successful update' do
    patch "/humans/#{@human.id}",
      { human: { name: 'Ash', brain_type: 'large' } }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 200, response.status
    assert_equal 'Ash', @human.reload.name
  end
end

# 4.13 Successful Updates With Patch
class HumansController < ApplicationController
  def update
    human = Human.find(params[:id])
    if human.update(human_params)
      render json: human, status: 200
    end
  end

  private

  def human_params
    params.require(:human).permit(:name, :brain_type)
  end
end

# 4.14 Unsuccessful Updates With Patch
class UpdatingHumansTest < ActionDispatch::IntegrationTest
  setup { @human = Human.create!(name: 'Robert', brain_type: 'small') }

  test 'unsuccessful update on bad name' do
    patch "/humans/#{@human.id}",
      { human: { name: nil } }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
    assert_equal 422, response.status
  end
end

# 4.15 Responding To Unsuccessful Updates
class HumansController < ApplicationController
  def update
    human = Human.find(params[:id])

    if human.update(human_params)
      render json: human, status: 200
    else
      render json: human.errors, status: 422
    end
  end

  private

  def human_params
    params.require(:human).permit(:name, :brain_type)
  end
end

# 4.16 Integration Tests With Delete
class DeletingZombiesTest < ActionDispatch::IntegrationTest
  setup { @zombie = Zombie.create!(name: 'Undead Jack', brain_type: 'large') }

  test 'deletes existing zombie' do
    delete "/zombies/#{@zombie.id}"
    assert_equal 204, response.status
  end
end

# 4.17 Responding To Delete By Destroying Records
class ZombiesController < ApplicationController
  def destroy
    zombie = Zombie.find(params[:id])
    zombie.destroy
    head 204
  end
end

# 4.18 Responding To Delete By Archiving Records
class Zombie < ActiveRecord::Base
  def archive
    self.available = false
    self.save
  end
  
  def self.find_available(id)
    find_by!(id: id, available: true)
  end
end

# 4.19 Responding To Delete Methods By Archiving Record
class ZombiesController < ApplicationController
  def show
    zombie = Zombie.find_available(params[:id])
    render json: zombie, status: 200
  end

  def destroy
    zombie = Zombie.find_available(params[:id])
    zombie.archive
    head 204
  end
end
