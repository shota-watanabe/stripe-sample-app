# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

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
    admin_root_path
  end
end
