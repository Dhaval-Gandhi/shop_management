class OrdersController < ApplicationController

  def index
    @search = params[:search]
    @orders = Order.includes(:customer).all
    @orders = @orders.where('customers.name ilike :search', search: "%#{@search}%") if @search.present?
  end

  def new
    @customers = Customer.all
    @items = Item.all
  end

  def customer_search
    @search = params[:search]
    @customers = Customer.all
    @customers = @customers.where('name ilike :search OR contact ilike :search', search: "%#{@search}%") if @search.present?
  end

  def item_search
    @search = params[:search]
    @items = Item.all
    @items = @items.where('name ilike :search', search: "%#{@search}%") if @search.present?
  end

end
