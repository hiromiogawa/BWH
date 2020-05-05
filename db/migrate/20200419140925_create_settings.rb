class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.integer :ftirewidth
      t.integer :rtirewidth
      t.float :flpress
      t.float :frpress
      t.float :rlpress
      t.float :rrpress
      t.integer :fdecay
      t.integer :rdecay
      t.string :remarks

      t.references :heat, null: false, foreign_key: true
      t.timestamps
    end
  end
end
