class CreateDigSites < ActiveRecord::Migration[6.0]
  def change
    create_table :dig_sites do |t|
      t.string :name
      t.string :location
      t.integer :user_id
    end
  end
end
