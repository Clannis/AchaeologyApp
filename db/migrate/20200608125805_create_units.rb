class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.string :size
      t.integer :dig_site_id
    end
  end
end
