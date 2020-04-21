class CreateTires < ActiveRecord::Migration[6.0]
  def change
    create_table :tires do |t|
      t.string :tirename
      
      t.timestamps
    end
  end
end
