class User < ActiveRecord::Base
    has_many :dig_sites

    has_secure_password
    validates :username, uniqueness: true
    
end