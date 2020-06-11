class TeamMemberController < ApplicationController
    
    get "/team_member/new" do 
        erb :"/team_members/new"
    end

    post "team_member/new" do

    end
end