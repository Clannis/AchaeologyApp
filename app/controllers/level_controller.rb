class LevelController < ApplicationController

    get "/levels/:id" do
        # binding.pry
        @level = Level.find(params[:id])
        erb :"/levels/show"
    end
    
end