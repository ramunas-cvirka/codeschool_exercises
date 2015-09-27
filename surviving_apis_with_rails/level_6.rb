# 6.2 Integration Testing Basic Auth
class ListingZombiesTest < ActionDispatch::IntegrationTest
  setup { @user = User.create!(username: 'foo', password: 'secret') }

  test 'valid authentication lists zombies' do
    get '/zombies', {}, { 'Authorization' => encode_credentials(@user.username, @user.password) }
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end
end

# 6.3 Testing Invalid Authentication
class ListingZombiesTest < ActionDispatch::IntegrationTest
  test 'invalid authentication responds with proper status code' do
    get '/zombies', {}, { 'Authorization' => '' }
    assert_equal 401, response.status
  end
end

# 6.4 Implementing Basic Auth
class ApplicationController < ActionController::Base

  before_action :authenticate

  protected
    def authenticate
      authenticate_basic_auth
    end

  	def authenticate_basic_auth
      authenticate_with_http_basic do |username, password|
        User.authenticate(username, password)
      end
    end
end

# 6.5 Custom Basic Auth Response
class ApplicationController < ActionController::Base

  before_action :authenticate

  protected
    def authenticate
      authenticate_basic_auth || render_unauthorized
    end

    def authenticate_basic_auth
      authenticate_with_http_basic do |username, password|
        User.authenticate(username, password)
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Basic realm="Zombies"'
      respond_to do |f|
        f.json { render json: 'Bad credentials', status: 401 }
        f.xml { render xml: 'Bad credentials', status: 401 }
      end
    end
end

# 6.6 Curl With Basic Auth
$ curl -H 'Accept: application/json' -u 'foo:secret' http://cs-zombies-dev.com:3000/zombies

# 6.8 Integration Testing Token Auth
class ListingZombiesTest < ActionDispatch::IntegrationTest
  setup { @user = User.create! }

  test 'valid token lists zombies' do
    get '/zombies', {}, { 'Authorization' => token_header(@user.auth_token) }
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end
end

# 6.9 Generating Auth Token
class User < ActiveRecord::Base
  before_create :set_auth_token

  private

    def set_auth_token
      return if auth_token.present?
      self.auth_token = TokenGenerator.create
    end
end

# 6.10 Implementing Token Based Auth
class ApplicationController < ActionController::Base
  before_action :authenticate

  protected
    def authenticate
      authenticate_token
    end

    def authenticate_token
      authenticate_with_http_token do |token|
        User.find_by(auth_token: token)
      end
    end
end

# 6.11 Custom Token Response
class ApplicationController < ActionController::Base
  before_action :authenticate

  protected
    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token|
        User.find_by(auth_token: token)
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Zombies"'
      respond_to do |f|
        f.json { render json: 'Bad credentials', status: 401 }
        f.xml { render xml: 'Bad credentials', status: 401 }
      end
    end
end

# 6.12 Curl and Token Based Auth
$ curl -H 'Accept: application/json' -H 'Authorization: Token token=a45fb396579a25458d23208560742610' http://cs-zombies-dev.com:3000/zombies
