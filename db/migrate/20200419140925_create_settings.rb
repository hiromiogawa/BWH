class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.string :ftirewidth
      t.string :rtirewidth
      t.float :flpress
      t.float :frpress
      t.float :rlpress
      t.float :rrpress
      t.float :flpress_after
      t.float :frpress_after
      t.float :rlpress_after
      t.float :rrpress_after
      t.integer :fdecay
      t.integer :rdecay
      t.string :remarks

      t.references :heat, null: false, foreign_key: true
      t.timestamps
    end
  end
end
