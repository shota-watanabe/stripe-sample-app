# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # after_action :create_stripe_account, only: [:after_sign_in_path_for]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # devise が用意しているメソッドで、サインイン後にどこに遷移するかを設定しているメソッド
  def after_sign_in_path_for(_resource)
    # devise のデフォルトは root_path になっている。今回は、管理者側のトップページ admin_root_path とする
    # ログイン済みの管理者のアカウントステータスが未確認もしくは無効なら、確認画面に遷移
     # Stripeアカウント作成
     account = Stripe::Account.create(
      type: "standard"
    )
   # アカウントリンク作成
   url = Stripe::AccountLink.create(
      account: account.id,
      # アカウントリンクの有効期限が切れているなどの理由で無効な場合に、ユーザーがリダイレクトされるURL
      refresh_url: root_url,
      return_url: root_url,
      type: "account_onboarding"
    )
  # redirect_to url.url, allow_other_host: true
     admin_root_path
  end

  # def create_stripe_account
  #   account = Stripe::Account.create(
  #     type: "standard"
  #   )
  #  # アカウントリンク作成
  #  url = Stripe::AccountLink.create(
  #     account: account.id,
  #     # アカウントリンクの有効期限が切れているなどの理由で無効な場合に、ユーザーがリダイレクトされるURL
  #     refresh_url: root_url,
  #     return_url: root_url,
  #     type: "account_onboarding"
  #   )
  #   redirect_to url.url, allow_other_host: true
  # end
end
