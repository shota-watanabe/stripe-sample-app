class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :name
    validates :status
  end
  enum status: {
    normal: 0, # 通常
    withdrawn: 1, # 退会済み
    banned: 2 # 停止
  }
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  # カート内商品の情報を配列で返すメソッド
  # Checkout セッションを作成する際に必要
  def line_items_checkout
    cart_items.map do |cart_item|
      {
        quantity: cart_item.quantity,
        price_data: {
          currency: 'jpy',
          unit_amount: cart_item.product.price,
          product_data: {
            name: cart_item.product.name,
            metadata: {
              product_id: cart_item.product_id
            }
          }
        }
      }
    end
  end

  def active_for_authentication?
    # status == 'normal' が true だった場合のみ、true を返す
    super && (status == 'normal')
  end
end
