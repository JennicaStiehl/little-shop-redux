class AddIndexToItems < ActiveRecord::Migration[5.1]
  def change
    add_index :items, :merchant_id
  end
end
