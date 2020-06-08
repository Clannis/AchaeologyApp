class Unit < ActiveRecord::Base
    belongs_to :dig_sites
    has_many :levels
    
end