class UsersController < ApplicationController
    get '/signup' do
        if logged_in?
            session[:message] = "Hello, you are already logged in!"
            redirect '/team'
        else
            erb :'/user/signup'
        end
    end

    get '/login' do
        if logged_in?
            session[:message] = "Hello, you are already logged in!"
            redirect '/team'
        else
            erb :'/user/login'
        end
    end

    get '/logout' do
        if logged_in?
            Player.destroy_all
            session.clear
            session[:message] = "Successfully logged out."
            redirect '/'
        else
            session[:message] = "You're not even logged in from the first place!"
            redirect '/'
        end
    end

    post '/signup' do
        if params[:username].empty?
            session[:message] = "Error: You need to enter in a username, try again."
            redirect '/signup'
        elsif params[:email].empty?
            session[:message] = "Error: You need to enter in a valid email, try again."
            redirect '/signup'
        elsif params[:password].empty?
            session[:message] = "Error: You need to enter in a password, try again."
            redirect '/signup'
        else
            username = User.find_by(username: params[:username])
            useremail = User.find_by(email: params[:email])
            if username && useremail
                session[:message] = "You already signed up with us, go to the login page instead!"
                redirect '/signup'
            elsif username
                session[:message] = "Username already exists, try a different username."
                redirect '/signup'
            elsif useremail
                session[:message] = "Email already exists, try a different email."
                redirect '/signup'
            else 
                session[:message] = "Successfully registered."
                user = User.create(username: params[:username], email: params[:email], password: params[:password])
                user.id = session[:user_id]
                redirect '/team'
            end
        end
    end

    post '/login' do
        if logged_in?
            session[:message] = "Hello, you are already logged in!"
            redirect '/team'
        end

        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            session[:message] = "Successfully logged in." 
            redirect '/team'
        else
            if !user
                session[:message] = "Account does not exist, either Sign Up or try a different account."
            else
                session[:message] = "Incorrect password, try again."
            end
            redirect '/login'
        end
    end

    get "/custom" do 
        @players = current_user.players #current users players
        erb :"/players/ptag"
        #do something else
    end 
end