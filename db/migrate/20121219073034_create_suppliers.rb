class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name, :null => false
      t.string :juridical_name
      t.string :ownership_type
      t.string :inn
      t.string :kpp
      t.string :ogrn
      t.string :juridical_address
      t.string :address
      t.string :phone
      t.string :representative_position
      t.string :representative_name
      t.string :account
      t.string :bank
      t.string :correspondent_account
      t.string :bik
      t.text :manager_contacts

      t.timestamps
    end
  end
end
