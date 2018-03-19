# Defines an invoice
class Invoice < ActiveRecord::Base
  validates :merchant_id, presence: true
  validates :status, presence: true

  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :merchant

  def self.merchants
    Invoice.all.map(&:merchant).uniq
  end
end
