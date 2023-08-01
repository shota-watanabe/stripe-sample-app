class Customer::CheckoutsController < ApplicationController
  before_action :authenticate_customer!

  def create
    line_items = current_customer.line_items_checkout
    session = create_session(line_items)
    # Allow redirection to the host that is different to the current host
    redirect_to session.url, allow_other_host: true
  end

  private

  def create_session(line_items)
    Stripe::Checkout::Session.create(
      # チェックアウトセッションを参照するための一意の文字列。今回は、顧客のID
      client_reference_id: current_customer.id,
      # 顧客のメールアドレス
      customer_email: current_customer.email,
      # チェックアウトセッションのモード（payment・setup・subscriptionがある）
      mode: 'payment',
      # 受け入れることができる支払い方法の種類のリスト
      payment_method_types: ['card'],
      # 顧客が購入した品目(line_items_checkout で作成したもの)
      line_items:,
      # 配送先住所として入力できる国
      shipping_address_collection: {
        allowed_countries: ['JP']
      },
      # 配送オプションの配送料作成に渡されるパラメータ
      shipping_options: [
        {
          shipping_rate_data: {
            type: 'fixed_amount',
            fixed_amount: {
              amount: 500,
              currency: 'jpy'
            },
            display_name: 'Single rate'
          }
        }
      ],
      # 支払いが成功した後に、リダイレクトされるURL
      success_url: root_url,
      # 決済をキャンセルした後に、リダイレクトされるURL
      cancel_url: "#{root_url}cart_items"
    )
  end
end
