class SessionController < ApplicationController

    get "/signup" do
        logged_in_redirect
        if !session[:user_id]
          @error = false
          erb :"/sessions/create_user"
        else
          redirect "/dig_sites"
        end
    end

    post "/signup" do
        logged_in_redirect
          @user = User.new(username: params[:username], email: params[:email], password: params[:password], name: slug(params[:name]), password_confirmation: params[:password_confirmation])
          if @user.save
            session[:user_id] = @user.id
            redirect "/dig_sites"
          else
            erb :"/sessions/create_user"
          end
        erb :"/sessions/create_user"
    end
    
    get "/login" do
        logged_in_redirect
        if session[:user_id]
          redirect "/dig_sites"
        else
          erb :"/sessions/login"
        end
    end

    post "/login" do 
        logged_in_redirect
        if params[:user].include?("@")
            user = User.find_by(email: params[:user])
        else
            user = User.find_by(username: params[:user])
        end
        if user 
          if user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/dig_sites"
          else
            @error = "Incorrect password"
            erb :"/sessions/login"
          end
        else
          @error = "No account associated with that Username or Email."
          erb :"/sessions/login"
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