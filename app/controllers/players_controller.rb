require 'open-uri'

class PlayersController < ApplicationController
    get '/players' do
        if logged_in?
            if @team = current_user.team
                if Player.all.size < 2
                    doc = Nokogiri::HTML(open("https://www.fantasypros.com/nba/player-rater.php"))
                    chart = doc.css("tbody")
                    chart.css("tr").each do |element|
                        temp = element.css(".player-label").text.strip
                        name = temp.split(" (")[0]
                        temp2 = temp.split(" - ")[1]
                        temp2[-1] = ""
                        position = temp2
                        Player.create(name: name, position: position, team_id: current_user.team.id)
                    end
                else
                    current_user.players.each do |element|
                        temp = element.name
                        temp2 = element.position
                        Player.find_by(name: temp, position: temp2).update(captain: false)
                    end
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
        arr = []
        params[:name].each do |element|
            temp = element.split(" - ")
            Player.find_by(name: temp[0], position: temp[1]).update(captain: true)
            arr << Player.find_by(name: temp[0], position: temp[1])
        end
        @array = arr
        @team = current_user.team
        erb :'/team/show'
    end
end