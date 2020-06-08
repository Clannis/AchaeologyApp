class UserController < ApplicationController

    get "/signup" do
        if !session[:user_id]
          @error = false
          erb :create_user
        else
          redirect "/dig_sites/index"
        end
    end
    
end