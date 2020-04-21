class CreateHeats < ActiveRecord::Migration[6.0]
  def change
    create_table :heats do |t|
      t.integer :number

      t.references :datalist, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.references :tire, null: false, foreign_key: true

      t.timestamps
    end
  end
end
