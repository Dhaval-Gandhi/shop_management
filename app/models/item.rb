class Item < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  enum unit: ["Kg", "Pcs"]

end
