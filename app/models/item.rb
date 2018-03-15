# Describes an Item in the store
class Item < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image, presence: true
  belongs_to :merchant

  def self.all_items
    Item.all
  end
end
