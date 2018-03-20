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
end
