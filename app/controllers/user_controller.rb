class UserController < ApplicationController

    get "/signup" do
        if !session[:user_id]
          @error = false
          erb :"/users/create_user"
        else
          redirect "/dig_sites/index"
        end
    end

    post "/signup" do
        if !params[:username].empty? && (!params[:email].empty? && params[:email].include?("@")) && !params[:password].empty?
            @user = User.new(username: params[:username], email: params[:email], password: params[:password])
            if @user.save
              session[:user_id] = @user.id
              redirect "/dig_sites/index"
            else
              erb :"/users/create_user"
            end
        end
        @error = "All fields must be filled in."
        erb :"/users/create_user"
    end
    
    get "/login" do
        if session[:user_id]
          redirect "/dig_sites/index"
        else
          erb :"/users/login"
        end
    end

    post "/login" do 
        if params[:user].include?("@")
            user = User.find_by(email: params[:user])
        else
            user = User.find_by(username: params[:user])
        end
        if user 
          if user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/dig_sites/index"
          else
            @error = "Incorrect password"
            erb :"/users/login"
          end
        else
          @error = "Incorrect Username/Email"
          erb :"/users/login"
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