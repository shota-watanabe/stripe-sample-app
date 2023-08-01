class Customer::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def index
    # current_customer に結びついている order を最新のものから順に取得
    # latest メソッドは、app/models/application_record.rb で定義したもの
    @orders = current_customer.orders.latest
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  def success; end
end
