class CreateTaxes < ActiveRecord::Migration[7.1]
  def change
    create_table :taxes do |t|
      t.decimal :icms_value
      t.decimal :ipi_value
      t.decimal :pis_value
      t.decimal :cofins_value
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
