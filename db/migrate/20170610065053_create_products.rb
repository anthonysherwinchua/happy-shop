class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.boolean :sold_out, default: false
      t.boolean :under_sale, default: false
      t.integer :price, null: false
      t.integer :sale_price, null: false

      t.timestamps
    end

    add_reference :products, :category, index: true
    add_foreign_key :products, :categories
  end

end
