require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :method_override, true
  set :public_folder, 'public'
  set :views, 'app/views'

  configure do
    enable :sessions
    set :session_secret, "my_secret"
  end

  get "/" do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      #binding.pry
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end
end
