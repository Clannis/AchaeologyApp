class CreateLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :levels do |t|
      t.string :beg_depth
      t.string :end_depth
      t.integer :unit_id
    end
  end
end
