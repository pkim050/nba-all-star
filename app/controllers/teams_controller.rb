class TeamsController < ApplicationController
    configure do
        enable :sessions
        set :session_secret, "my_secret"
    end

    get '/team' do
        if logged_in?
            if @team = current_user.team
                @array = []
                #binding.pry
                if !current_user.players.empty?
                    current_user.players.each do |element|
                        temp = element.name
                        temp2 = element.position
                        @array << Player.find_by(name: temp, position: temp2, captain: true) if Player.find_by(name: temp, position: temp2, captain: true) != nil
                    end
                end
                erb :'/team/show'
            else
                erb :'/team/index'
            end
        else
            session[:message] = "Please log in order to see the content."
            redirect '/login'
        end
    end
    
    post '/team' do
        if logged_in?
            if params[:name].empty?
                session[:message] = "Please input a name for the team."
                redirect '/team/new'
            else
                Team.create(name: params[:name], user_id: current_user.id)
                redirect '/team'
            end
        else
            redirect '/login'
        end
    end

    get '/team/new' do
        if logged_in?
            if current_user.team
                session[:message] = "You already have a team, in order to create a new team, delete the team that you currently have."
                redirect '/team'
            else
                erb :'/team/new'
            end
        else
            session[:message] = "Please log in order to see the content."
            redirect '/login'
        end
    end

    get '/team/edit' do
        if logged_in?
            if @team = current_user.team
                @team = current_user.team
                erb :'/team/edit'
            else
                session[:message] = "You must first create a team in order to see this content."
                redirect '/team'
            end
        else
            redirect '/login'
        end
    end

    post '/team/edit' do
        if logged_in?
            if @team = current_user.team
                @team.update(name: params[:name])
                redirect '/team'
            else
                session[:message] = "Input a name for the team."
                redirect '/team/edit'
            end
        else
            redirect '/login'
        end
    end

    delete '/team/delete' do
        if logged_in?
            @team = current_user.team
            temp = @team.name
            @team.destroy
            session[:message] = "Team #{temp} has been deleted."
            redirect '/team'
        else
            redirect '/login'
        end
    end
end