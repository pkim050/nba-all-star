require 'open-uri'

class PlayersController < ApplicationController
    get '/players' do
        if logged_in?
            if @team = current_user.team
                @all = []
                doc = Nokogiri::HTML(open("https://www.fantasypros.com/nba/player-rater.php"))
                chart = doc.css("tbody")
                chart.css("tr").each do |element|
                    temp = element.css(".player-label").text.strip
                    name = temp.split(" (")[0]
                    temp2 = temp.split(" - ")[1]
                    temp2[-1] = ""
                    position = temp2
                    @all << {name: name, position: position}
                end
                erb :'/players/index'
            else
                session[:message] = "You must first create a team in order to see this content."
                redirect '/team'
            end
        else
            session[:message] = "Please log in order to see the content."
            redirect '/login'
        end
    end

    post '/playersteam' do
        Players.destroy_all
        params[:name].each do |element|
            temp = element.split(" - ")
            Players.create(name: temp[0], position: temp[1], team_id: current_user.team.id)
        end
        @players = Players.all
        redirect '/team'
    end
end