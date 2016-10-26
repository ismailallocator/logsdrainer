class LogsController < ApplicationController

  before_action :authenticate

  def index
    render  json: params.to_json
  end

  private


  def authenticate
    if authenticate_with_http_basic { |user, pass| user == 'user' && pass == 'password' }
      return true
    else
      request_http_basic_authentication
    end
  end
end
