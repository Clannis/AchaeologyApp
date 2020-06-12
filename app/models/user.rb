class User < ActiveRecord::Base
    has_many :dig_sites
    has_many :units, through: :dig_sites
    has_many :levels, through: :units
    has_many :artifacts, through: :levels

    has_secure_password
    validates :username, uniqueness: true
    validates :email, uniqueness: :true
    
    def display_name
        name.split("-").collect do |n|
            n.capitalize
        end.join(" ")
    end

end