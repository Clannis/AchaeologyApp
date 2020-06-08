class Level < ActiveRecord::Base
    belongs_to :unit
    has_many :artifacts
    
end