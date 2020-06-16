

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views , 'app/views'
        enable :sessions
        set :session_secret, ENV['SESSION_SECRET']
    end

    get "/" do
        if logged_in?
            redirect "/dig_sites"
        else
            erb :index
        end
    end

    helpers do

        def current_user
            User.find(session[:user_id])
        end
    
        def logged_in?
            !!session[:user_id]
        end

        def logged_in_redirect
            redirect "/dig_sites" if logged_in?
        end
    
        def authenticate
            redirect "/login" if !logged_in?
        end

        def slug(text)
            text.downcase.gsub(" ","-")
        end

        def ownership(object)
            if current_user.id != object.user_id
                redirect "/dig_sites"
            end
        end

    end
    
end