class User < ActiveRecord::Base
    has_many :dig_sites
    has_one :team_member

    has_secure_password
    validates :username, uniqueness: true
    
end