class CreateJoins < ActiveRecord::Migration[6.0]
  def change
    create_table :joins do |t|
      t.string :type
      t.references :user, null: false, foreign_key: true
      t.references :circuit, null: false, foreign_key: true

      t.index [:user_id, :circuit_id , :type], unique: true
      t.timestamps
    end
  end
end
