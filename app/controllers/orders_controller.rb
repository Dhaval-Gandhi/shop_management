class OrdersController < ApplicationController

  def index
    @search = params[:search]
    @orders = Order.joins(:customer).all
    @orders = @orders.where('customers.name ilike :search', search: "%#{@search}%") if @search.present?
  end

  def show
    @order = Order.find_by_id(params[:id])
    pdf_html = ActionController::Base.new.render_to_string(template: 'pdfs/order', layout: false, locals: { order: @order })
    pdf = WickedPdf.new.pdf_from_string(pdf_html, page_height: 148, page_width: 105, margin: {top: 3,bottom: 3, left: 3, right: 3 })
    send_data pdf, filename: "#{Time.now.to_i}.pdf"
  end

  def new
    @customers = Customer.all
    @items = Item.all
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:notice] = 'Order Successfully Created!'
      redirect_to orders_path
    else
      flash[:alert] = @order.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    @customers = Customer.all
    @items = Item.all
    @order = Order.find_by_id(params[:id])
  end

  def update
    @order = Order.find_by_id(params[:id])
    if @order.update(order_params)
      flash[:notice] = 'Order Successfully Updated!'
      redirect_to orders_path
    else
      flash[:alert] = @order.errors.full_messages.join(', ')
      render :edit
    end
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

  private

  def order_params
    params.require(:order).permit(:customer_id, :date, order_items_attributes: [:id, :item_id, :qty, :rate, :_destroy])
  end

end
