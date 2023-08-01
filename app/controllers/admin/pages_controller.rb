class Admin::PagesController < ApplicationController
  before_action :authenticate_admin!

  def home
    # @selected ... 絞り込み検索を行うセレクトボックスの値を制御するためのもの
    @orders, @selected = get_orders(params)
    today_orders = Order.created_today
    @today_total_orders = total_orders(today_orders)
    @today_total_sales = total_sales(today_orders)
  end

  private

  def get_orders(params)
    if !params[:status].present? || !Order.statuses.keys.to_a.include?(params[:status])
      # 「customer」と単数形なのは、customers テーブルが orders テーブルから見て親だから
      return [Order.eager_load(:customer).latest, 'all']
    end

    get_by_enum_value(params[:status])
  end

  # 注文履歴を status カラムの値で絞り込む
  def get_by_enum_value(status)
    case status
    when 'waiting_payment'
      [Order.latest.waiting_payment, 'waiting_payment']
    when 'confirm_payment'
      [Order.latest.confirm_payment, 'confirm_payment']
    when 'shipped'
      [Order.latest.shipped, 'shipped']
    when 'out_of_delivery'
      [Order.latest.out_of_delivery, 'out_of_delivery']
    when 'delivered'
      [Order.latest.delivered, 'delivered']
    end
  end

  # 一日の注文数を返す
  def total_orders(orders)
    orders.count
  end

  # 一日の売り上げを返す
  def total_sales(orders)
    orders.sum(:billing_amount)
  end
end
