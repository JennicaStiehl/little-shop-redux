# Describes items on an invoice
class InvoiceItem < ActiveRecord::Base
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price
  belongs_to :invoice
  belongs_to :item

  def formatted_price
    formatted = format('%2.2f', unit_price / 100.0)
    top, bottom = formatted.split('.')

    price_string = deliminate(top)

    "$#{price_string}.#{bottom}"
  end

  def deliminate(top)
    top.reverse!
    split_string = top.scan(/.{1,3}/)
    split_string.reverse!
    split_string.map(&:reverse).join(',')
  end
end
