class CreateArtifacts < ActiveRecord::Migration[6.0]
  def change
    create_table :artifacts do |t|
      t.string :local_id
      t.string :artifact_type
      t.string :description
      t.integer :level_id
      t.timestamps
    end
  end
end
