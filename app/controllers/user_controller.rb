class UserController < ApplicationController

    get "/signup" do
        if !session[:user_id]
          @error = false
          erb :"/users/create_user"
        else
          redirect "/dig_sites"
        end
    end

    post "/signup" do
        if !params[:username].empty? && (!params[:email].empty? && params[:email].include?("@")) && !params[:password].empty? && !params[:name].empty?
            @user = User.new(username: params[:username], email: params[:email], password: params[:password], name: slug(params[:name]))
            if @user.save
              session[:user_id] = @user.id
              redirect "/dig_sites"
            else
              erb :"/users/create_user"
            end
        end
        @error = "All fields must be filled in."
        erb :"/users/create_user"
    end
    
    get "/login" do
        if session[:user_id]
          redirect "/dig_sites"
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
            redirect "/dig_sites"
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

    get "/users/:id" do
      @user = current_user
      erb :"/users/show"
    end

    get "/users/:id/edit" do
      @user = User.find(params[:id])
      erb :"/users/edit"
    end

    patch "/users/:id" do
      @user = User.find(params[:id])
      if @user == current_user
        if !params[:name].empty?
          @user.name = params[:name]
        end
        if !params[:email].empty?
          @user.email = params[:email]
        end
        @user.save
        redirect "/user/#{current_user.id}"
      else
        error
        redirect "/user/#{current_user.id}"
      end
    end
    
end