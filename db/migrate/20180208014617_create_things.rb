class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.string :name
      t.string :description
      t.string :notes

      t.timestamps null: false
    end
  end
end
