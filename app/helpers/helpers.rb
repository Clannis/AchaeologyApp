class Helpers

    def self.current_user
        User.find(session[:user_id])
    end

    def self.logged_in?
        !!session[:user_id]
    end

    def self.authenticate
        redirect "/login" if !logged_in?
    end
end