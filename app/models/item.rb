# Describes an Item in the store
class Item < ActiveRecord::Base
  validates_presence_of :title,
                        :description,
                        :price,
                        :image

  belongs_to :merchant
  has_many :invoice_items

  def self.avg_price
    format_price(Item.average(:price))
  end

  def self.format_price(price)
    formatted = format('%2.2f', price / 100.0)
    top, bottom = formatted.split('.')

    price_string = deliminate(top)

    "$#{price_string}.#{bottom}"
  end

  def formatted_price
    Item.format_price(price)
  end

  def self.deliminate(top)
    top.reverse!
    split_string = top.scan(/.{1,3}/)
    split_string.reverse!
    split_string.map(&:reverse).join(',')
  end

  def self.newest
    Item.all
        .order('created_at DESC')
        .first
  end

  def self.oldest
    Item.all
        .order('created_at ASC')
        .first
  end
end
