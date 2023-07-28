class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  # モデル名.latest とすると、created_at の値を 降順 で並び替えてくれる
  scope :latest, -> { order(created_at: :desc) }
end
