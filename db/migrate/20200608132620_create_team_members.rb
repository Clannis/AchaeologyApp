class CreateTeamMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :team_members do |t|
      t.string :name
      t.string :credentials
      t.integer :age
      t.string :email
      t.string :phone_number
      t.integer :dig_site_id
    end
  end
end
