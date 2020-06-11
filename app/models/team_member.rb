class TeamMember < ActiveRecord::Base
    has_many :dig_sites, through: :teammember_digsite
    belongs_to :user
end