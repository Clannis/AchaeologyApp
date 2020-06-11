class DigSite < ActiveRecord::Base
    belongs_to :user
    has_many :units
    has_many :levels, through: :units
    has_many :artifacts, through: :levels
    has_many :team_members, through: :teammember_digsite
end