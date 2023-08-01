class Order < ApplicationRecord
  belongs_to :customer
  enum status: {
    waiting_payment: 0, # 入金待ち
    confirm_payment: 1, # 入金確認
    shipped: 2, # 出荷済み
    out_of_delivery: 3, # 配送中
    delivered: 4 # 配達済み
  }
  has_many :order_details, dependent: :destroy

  # scope :waiting_payment, -> { where(status: 'waiting_payment') }
  # scope :confirm_payment, -> { where(status: 'confirm_payment') }
  # scope :shipped, -> { where(status: 'shipped') }
  # scope :out_of_delivery, -> { where(status: 'out_of_delivery') }
  # scope :delivered, -> { where(status: 'delivered') }

  # 過去一日のデータを全て取得
  scope :created_today, -> { where('orders.created_at >= ?', Time.zone.now.beginning_of_day) }
end
