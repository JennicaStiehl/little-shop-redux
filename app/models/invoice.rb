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

  def self.status_percentages
    total = Invoice.count.to_f

    {
      pending: (Invoice.where(status: 'pending').count / total) * 100,
      shipped: (Invoice.where(status: 'shipped').count / total) * 100,
      returned: (Invoice.where(status: 'returned').count / total) * 100
    }
  end
end
