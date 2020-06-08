class UserController < ApplicationController

    get "/signup" do
        if !session[:user_id]
          @error = false
          erb :create_user
        else
          redirect "/dig_sites/index"
        end
    end

    post "/signup" do
        if !params[:username].empty? && (!params[:email].empty? && params[:email].include?("@")) && !params[:password].empty?
            user = User.new(username: params[:username], email: params[:email], password: params[:password])
            if user.save
            session[:user_id] = user.id
            redirect "/dig_sites/index"
            end
        end
        redirect "/signup"
    end
    
    get "/login" do
        if session[:user_id]
          redirect "/dig_sites/index"
        else
          erb :login
        end
    end

    post "/login" do 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect "/dig_sites/index"
        else
          redirect "/login"
        end
    end

    get "/logout" do
        if session[:user_id]
            session.clear
            redirect "/login"
        else
            redirect "/"
        end
    end

end