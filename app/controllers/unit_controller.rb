class UnitController < ApplicationController
    
    get "/units/:id" do
        @unit = Unit.find(params[:id])
        erb :"/units/show"    
    end

end