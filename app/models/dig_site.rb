class DigSite < ActiveRecord::Base
    belongs_to :user
    has_many :units
    has_many :team_members
end