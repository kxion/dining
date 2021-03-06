#coding: UTF-8
class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @orders = current_user.orders.page(params[:page]).per(30)
  end

  def create
    @order = current_user.orders.new message: params[:message], address: params[:address], phone: params[:phone], name: params[:name]
    @cart = current_user.cart
    @order.store_id = @cart.store_id

    if @order.store_id.blank? || @cart.line_items.blank?
      return redirect_to :back, alert: "请先选择一件商品.."
    end

    @cart.line_items.each do |l|
      @order.line_items.new quantity: l.quantity, price: l.price, product_id: l.product_id, user_id: current_user.id, product_title: l.product_title
    end

    if @order.save
      @cart.line_items.destroy_all
      return redirect_to orders_path, notice: "成功下单啦！ 食物马上送到，稍等哦~"
    else
      return redirect_to :back, alert: @order.errors.full_messages.to_sentence
    end
  end
end
