class CustomersController < ApplicationController
  def index
    @search = params[:search]
    @customers = Customer.all
    @customers = @customers.where('name ilike :search OR contact ilike :search', search: "%#{@search}%") if @search.present?
  end

  def show
    @customer = Customer.find_by_id(params[:id])
    @orders = @customer.orders
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

  def destroy
    @customer = Customer.find_by_id(params[:id])
    if @customer.destroy
      flash[:notice] = "Customer deleted succesfully"
      redirect_to customers_path
    else
      flash[:alert] = @customer.errors.full_messages.join(', ')
      redirect_to customers_path
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :contact, :address)
  end
end
