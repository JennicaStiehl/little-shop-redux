# Describes an Item in the store
class Item < ActiveRecord::Base
  validates_presence_of :title,
                        :description,
                        :price,
                        :image

  belongs_to :merchant
  has_many :invoice_items

  def formatted_price
    format('$%2.2f', price / 100.0)
  end
end
