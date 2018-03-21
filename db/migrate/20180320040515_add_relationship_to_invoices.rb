class AddRelationshipToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_index :invoices, :merchant_id
  end
end
