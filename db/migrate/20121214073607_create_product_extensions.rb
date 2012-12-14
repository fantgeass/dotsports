class CreateProductExtensions < ActiveRecord::Migration
  def change
    create_table :product_extensions do |t|
      t.references :product
      t.float :old_price

      t.timestamps
    end
    add_index :product_extensions, :product_id
  end
end
