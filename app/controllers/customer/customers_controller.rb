class Customer::CustomersController < ApplicationController
  before_action :authenticate_customer!

  # 退会確認画面の表示
  def confirm_withdraw; end

  # 退会実行処理の実行
  def withdraw
    current_customer.update(status: 'withdrawn')
    # セッション情報を削除し、ログアウト
    reset_session
    # ルートパスにリダイレクト
    redirect_to root_path, notice: 'Successfully withdraw from Ecommerce'
  end
end
