# coding: UTF-8
class Storer::ProductsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_user_is_storer
  before_filter :load_store

  def index
  end

  def new
  end

  def create
    @store.products.build params[:product]

    if @store.save
      redirect_to :back, notice: "成功!"
    else
      redirect_to :back, alert: @store.errors.full_messages.to_sentence
    end
  end

  def show

  end

  def edit

  end

  def update
    @product = @store.products.find params[:id]

    @product.update_attributes params[:product]

    if @store.save
      redirect_to :back, notice: "成功!"
    else
      redirect_to :back, alert: @store.errors.full_messages.to_sentence
    end
  end

  private
  def ensure_user_is_storer
    authorize! :manage, :store
  end

  def load_store
    @store = current_user.store
    if @store.nil?
      redirect_to storer_path, alert: "请先建立商店"
    end
  end
end
