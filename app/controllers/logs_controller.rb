class LogsController < ApplicationController

  before_action :authenticate

  def create
    render  json: params.to_json
  end

  private


  def authenticate
    if authenticate_with_http_basic { |user, pass| user == 'user' && pass == 'password' }
      return true
    else
      render_unauthorized
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Basic realm="Application"'
    render json: { message: 'Bad credentials' }, status: 401
  end
end
