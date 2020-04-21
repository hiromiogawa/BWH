class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.date :day

      t.references :circuit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
