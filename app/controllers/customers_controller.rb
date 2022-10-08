class CustomersController < ApplicationController
  def index
    @search = params[:search]
    @customers = Customer.all
    @customers = @customers.where('name ilike :search OR contact ilike :search', search: "%#{@search}%") if @search.present?
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash[:notice] = "Customer added succesfully"
      redirect_to customers_path
    else
      flash[:alert] = @customer.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    @customer = Customer.find_by_id(params[:id])
  end

  def update
    @customer = Customer.find_by_id(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "Customer updated succesfully"
      redirect_to customers_path
    else
      flash[:alert] = @customer.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :contact, :address)
  end
end
