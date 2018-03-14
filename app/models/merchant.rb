# Describes a merchant
class Merchant < ActiveRecord::Base
  validates :name, presence: true
end
