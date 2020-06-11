class TeamMemberDigSite < ActiveRecord::Base
    belongs_to :dig_site
    belongs_to :team_member
end