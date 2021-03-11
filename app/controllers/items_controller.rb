class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :move_to_edit_update, only: [:edit, :update,:destroy]
  # before_action :tag_item, only: :edit
  
  def index
    @items = Item.all.order("created_at DESC")
    # @item = Item.new
  end
  
  def new
    @item_tag = ItemsTag.new
  end

  def create
    @item_tag = ItemsTag.new(item_params)
    if @item_tag.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def edit
    @item_tag = Item.find(params[:id])
  end

  def update
    @item_tag = ItemsTag.new(edit_params)
    if @item_tag.update(@item)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:items_tag).permit(:message,:name, :text, :category_id, :status_id, :burden_id, :area_id, :days_id, :price,images: []).merge(user_id: current_user.id)
  end

  def edit_params
    params.require(:item).permit(:message,:name, :text, :category_id, :status_id, :burden_id, :area_id, :days_id, :price,images: []).merge(user_id: current_user.id,item_id: params[:id])
  end  

  def set_item  
    @item = Item.find(params[:id])
  end

  def tag_item
    @item_tag = @item.tags[0]
  end


  def move_to_edit_update
    # ログイン出品者が売却済み商品編集ページへ遷移するとトップページに遷移します。
    if current_user.id != @item.user_id || @item.order.present?
       redirect_to root_path
    end
  end


end