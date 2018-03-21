# Describes a merchant
class Merchant < ActiveRecord::Base
  validates :name, presence: true
  has_many :items

  def self.most_items
    select('merchants.*, count(items) AS item_count')
      .joins(:items)
      .group(:id)
      .order('item_count DESC')
      .first
  end

  def self.highest_cost
    select('merchants.*, sum(items.price) AS total_cost')
      .joins(:items)
      .group(:id)
      .order('total_cost DESC')
      .first
  end

  def item_count
    items.count
  end

  def avg_item_price
    items.average(:price).to_i
  end

  def total_cost
    items.sum(:price).to_i
  end

  def self.format_price(price)
    formatted = format('%2.2f', price / 100.0)
    top, bottom = formatted.split('.')

    price_string = deliminate(top)

    "$#{price_string}.#{bottom}"
  end

  def self.deliminate(top)
    top.reverse!
    split_string = top.scan(/.{1,3}/)
    split_string.reverse!
    split_string.map(&:reverse).join(',')
  end
end
