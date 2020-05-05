class CreateHeats < ActiveRecord::Migration[6.0]
  def change
    create_table :heats do |t|
      t.integer :number
      t.string :tirename
      t.string :weather
      t.float :temp
      t.string :roadcondition
      t.float :roadtemp

      t.references :datalist, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.references :circuit, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
