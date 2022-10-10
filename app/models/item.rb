class Item < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_many :order_items, dependent: :destroy

  enum unit: ["Kg", "Pcs"]

end
