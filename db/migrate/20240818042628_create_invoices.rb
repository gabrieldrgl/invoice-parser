class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.string :series
      t.string :number
      t.datetime :emission_date

      t.timestamps
    end
  end
end
