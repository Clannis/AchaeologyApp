class Unit < ActiveRecord::Base
    belongs_to :dig_site
    has_many :levels
    
end