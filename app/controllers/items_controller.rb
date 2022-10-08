class ItemsController < ApplicationController

  def index
    @search = params[:search]
    @items = Item.all
    @items = @items.where('name ilike :search', search: "%#{@search}%") if @search.present?
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "Item added succesfully"
      redirect_to items_path
    else
      flash[:alert] = @item.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    @item = Item.find_by_id(params[:id])
  end

  def update
    @item = Item.find_by_id(params[:id])
    if @item.update(item_params)
      flash[:notice] = "Item updated succesfully"
      redirect_to items_path
    else
      flash[:alert] = @item.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def item_params
    params[:item][:unit] = params[:item][:unit].to_i
    params.require(:item).permit(:name, :unit, :rate)
  end

end
