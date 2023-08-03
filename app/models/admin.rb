class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum identification_status: {
  unconfirmed: 0, # 通常
  available: 1, # 退会済み
  unavailable: 2 # 停止
}
end
