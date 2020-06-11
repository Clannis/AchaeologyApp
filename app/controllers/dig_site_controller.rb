class DigSiteController < ApplicationController

    get "/dig_sites/index" do
        @user = current_user
        erb :"/dig_sites/index"
    end
    
end