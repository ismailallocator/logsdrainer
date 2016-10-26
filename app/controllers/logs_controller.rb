class LogsController < ApplicationController

  before_action :authenticate

  def create
    puts "*****************************"
    puts request.env['HTTP_LOGPLEX_DRAIN_TOKEN']
    puts request.inspect
    puts request.body.read
    puts "+++++++++++++++++++++++++++++"
    head :ok
  end

  private


  def authenticate
    if authenticate_with_http_basic { |user, pass| user == 'user' && pass == 'secret' }
      return true
    else
      render_unauthorized
    end
  end

  # heroku drains:add https://user:pass@mylogdrain.herokuapp.com/logs -a myapp
  # heroku drains:add https://user:secret@allocatorlogs.herokuapp.com/logs -a staging-hedgepo


  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Basic realm="Application"'
    render json: { message: 'Bad credentials' }, status: 401
  end
end
