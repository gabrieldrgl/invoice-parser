class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :ncm
      t.string :cfop
      t.string :unit
      t.integer :quantity
      t.decimal :unit_price
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
