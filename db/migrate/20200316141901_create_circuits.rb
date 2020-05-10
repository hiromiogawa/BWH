class CreateCircuits < ActiveRecord::Migration[6.0]
  def change
    create_table :circuits do |t|
      t.string :name
      t.string :url
      t.string :img
      t.string :img2
      t.timestamps
    end
  end
end
