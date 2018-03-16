# Merchants migration
class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.text :name
      t.timestamps null: false
    end
  end
end
