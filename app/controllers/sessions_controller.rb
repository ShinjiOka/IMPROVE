class SessionsController < ApplicationController
  def create
    admin = Admin.find_by(email: params[:session][:email])
    if admin && admin.authenticate(params[:session][:password])
      session[:admin_id] = admin.id
      redirect_to dashboard_path # ログイン後のリダイレクト先を指定する
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render 'new' # ログインフォームを再度表示する
    end
  end

  def destroy
    session.delete(:admin_id)
    redirect_to root_path
  end
end

