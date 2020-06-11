class CreateTeammemberDigsite < ActiveRecord::Migration[6.0]
  def change
    create_table :teammember_digsite do |t|
      t.integer :team_member_id
      t.integer :dig_site_id
      t.timestamps
    end
  end
end
