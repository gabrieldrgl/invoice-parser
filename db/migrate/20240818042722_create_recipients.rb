class CreateRecipients < ActiveRecord::Migration[7.1]
  def change
    create_table :recipients do |t|
      t.string :name
      t.string :cnpj
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
