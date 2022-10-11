class OrderItem < ApplicationRecord

  belongs_to :order
  belongs_to :item

  before_save :calculate_amount
  after_commit :calculate_order_net_amount

  def calculate_amount
    self.qty = self.qty.to_f.zero? ? 1 : self.qty.to_f
    self.rate = self.rate.to_f.zero? ? 1 : self.rate.to_f 
    self.amount = self.qty.to_f * self.rate.to_f
  end

  def calculate_order_net_amount
    order = self.order
    order.amount = order.order_items.sum(:amount).to_f
    order.discount = order.discount.to_f.zero? ? 0.0 : order.discount.to_f
    order.net_amount = order.amount.to_f + order.discount.to_f
    order.save
  end

end
