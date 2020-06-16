

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, Proc.new { File.join(root, "public") }
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

        def render_navbar
            if logged_in?
                erb :"/navbars/logged_in_navbar"
            else
                erb :"/navbars/logged_out_navbar"
            end
        end

        def render_object_navbar(object)
            if logged_in?
                if object.class == DigSite
                    erb :"/navbars/dig_sites_navbar"
                elsif object.class == Unit
                    erb :"/navbars/units_navbar"
                elsif object.class == Level
                    erb :"/navbars/levels_navbar"
                elsif object.class == Artifact
                    erb :"/navbars/artifacts_navbar"
                end
            end
        end

    end
    
end