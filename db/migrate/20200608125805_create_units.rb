class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.string :size
      t.integer :dig_site_id
      t.string :local_id
    end
  end
end
