# 3.2 Testing with Mime Type
class ListingHumansTest < ActionDispatch::IntegrationTest
  test 'returns humans in JSON' do
    get '/humans', {}, { 'Accept' => Mime::JSON }
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end
end

# 3.3 Using respond_to
class HumansController < ApplicationController
  def index
    humans = Human.all

    respond_to do |format|
      format.json { render json: humans, status: :ok }
      format.xml { render xml: humans, status: :ok }
    end
  end
end

# 3.4 Listing Mime Types
> Mime::SET

# 3.5 Using Custom Headers with curl
$ curl -IH "Accept: application/json" http://cs-zombies-dev.com:3000/humans

# 3.7 Testing With The Language Set to English
class ChangingLocalesTest < ActionDispatch::IntegrationTest
  test 'returns list of humans in English' do
    get '/humans', {}, { 'Accept-Language' => 'en', 'Accept' => Mime::JSON }
    assert_equal 200, response.status
    human = json(response.body).first
    assert_equal "My name is #{human[:name]} and I am alive!", human[:message]
  end
end

# 3.8 Setting The Language For The Response
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  protected
    def set_locale
      I18n.locale = request.headers['Accept-Language']
    end
end

# 3.9 Using Jbuilder to Return Localized JSON
json.array(@humans) do |human|
  json.extract! human, :id, :name, :brain_type
  json.message I18n.t('human_message', name: human.name)
end

# 3.10 Using Locale Templates
en:
  human_message: 'My name is %{name} and I am still alive!'