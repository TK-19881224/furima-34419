class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :show, :update]
  before_action :move_to_edit_update, only: [:edit, :update]
  
  def index
    @items = Item.all.order("created_at DESC")
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params) 
      redirect_to item_path
    else
      render :edit
    end
  end


  private

  def item_params
    params.require(:item).permit(:image, :name, :text, :category_id, :status_id, :burden_id, :area_id, :days_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_edit_update
    unless @item.user_id == current_user.id
      redirect_to root_path
    end
  end


end