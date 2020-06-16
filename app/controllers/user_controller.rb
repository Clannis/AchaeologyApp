class UserController < ApplicationController

    get "/users/:id" do
      authenticate
      @user = current_user
      erb :"/users/show"
    end

    get "/users/:id/edit" do
      authenticate
      @user = User.find(params[:id])
      erb :"/users/edit"
    end

    patch "/users/:id" do
      authenticate
      @user = User.find(params[:id])
      if @user == current_user
        if !@user.authenticate(params[:password])
          @user.errors.add(:password, "was incorrect")
          erb :"/users/edit"
        else
          if !params[:name].empty?
            @user.name = slug(params[:name])
          end
          if !params[:email].empty?
            if params[:email].include?("@")
              @user.email = params[:email]
            else
              @user.errors.add(:email, "was not a valid email address")
            end
          end
          if @user.errors.any?
            erb :"/users/edit"
          else
            if !params[:new_password].empty?
              @user.update(password: params[:new_password], password_confirmation: params[:new_password_confirmation])
            end
            if @user.errors.any?
              erb :"/users/edit"
            else
              @user.save
              redirect "/users/#{current_user.id}"
            end
          end
        end 
      else
        erb :"/users/edit"
      end
    end
    
end