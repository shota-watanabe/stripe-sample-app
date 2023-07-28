class Product < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :description
    validates :price
    validates :stock
    validates :image
  end
  has_one_attached :image
  # 価格を降順にproductを取得
  scope :price_high_to_low, -> { order(price: :desc) }
  # 価格を昇順にproductを取得
  scope :price_low_to_high, -> { order(price: :asc) }
end
