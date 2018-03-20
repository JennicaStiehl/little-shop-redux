# Describes an Item in the store
class Item < ActiveRecord::Base
  validates_presence_of :title,
                        :description,
                        :price,
                        :image

  belongs_to :merchant
  has_many :invoice_items

  def formatted_price
    formatted = format('%2.2f', price / 100.0)
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
