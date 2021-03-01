class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index  
    @purchase = Purchase.new
    if @purchase.user_id == current_user.id
      redirect_to root_path
    end
  end

  def create
    @purchase = Purchase.new(purchase_params)
    if @purchase.valid?
      pay_item
      @purchase.save
      redirect_to root_path
    else
      render :index
    end
  end



  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:purchase).permit(:address, :building_name, :postal_code, :area_id, :municipalites, :phone_number ).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = "sk_test_6538078ac821c015aaf6316c"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: purchase_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

end
