class Level < ActiveRecord::Base
    belongs_to :units
    has_many :artifacts
    
end