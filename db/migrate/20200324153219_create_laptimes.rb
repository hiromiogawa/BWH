class CreateLaptimes < ActiveRecord::Migration[6.0]
  def change
    create_table :laptimes do |t|
      t.float :sec1
      t.float :sec2
      t.float :sec3
      t.float :total
      
      t.references :heat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
