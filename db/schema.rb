# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_18_231234) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invoices", force: :cascade do |t|
    t.string "series"
    t.string "number"
    t.datetime "emission_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issuers", force: :cascade do |t|
    t.string "name"
    t.string "cnpj"
    t.bigint "invoice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_issuers_on_invoice_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "ncm"
    t.string "cfop"
    t.string "unit"
    t.integer "quantity"
    t.decimal "unit_price"
    t.bigint "invoice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_products_on_invoice_id"
  end

  create_table "recipients", force: :cascade do |t|
    t.string "name"
    t.string "cnpj"
    t.bigint "invoice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_recipients_on_invoice_id"
  end

  create_table "taxes", force: :cascade do |t|
    t.decimal "icms_value"
    t.decimal "ipi_value"
    t.decimal "pis_value"
    t.decimal "cofins_value"
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_taxes_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "issuers", "invoices"
  add_foreign_key "products", "invoices"
  add_foreign_key "recipients", "invoices"
  add_foreign_key "taxes", "products"
end
