# Describes items on an invoice
class InvoiceItem < ActiveRecord::Base
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price
  belongs_to :invoice
  has_many :items
end
