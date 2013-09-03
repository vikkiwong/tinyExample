#encoding: utf-8
class SessionsController < ApplicationController
	skip_before_filter :login_check

  layout 'sessions'

  # 登陆方法
  # 
  # ping.wang
  def create
    if Rails.env == "production"
      @user = Customer.check_user(params[:email],params[:password])
    else
      @user = check_user(params[:email],params[:password])
    end

    if @user.present?
      # 跳转到登录前访问的页面
      back_path = session[:back_path]
      back_path = "/" if back_path.blank? || back_path =~ /login/
      session[:back_path] = nil

      set_session and redirect_to(back_path)
    else
      redirect_to("/login" ,:notice => "用户名或密码错误，请重新登陆")
    end
  end

  def destroy
    reset_session
    redirect_to("/login")
  end

  protected
  # 查找数据库中是否有目标用户
  #
  # ping.wang
  def check_user(email, password)
    return nil unless email.present?
    user = Customer.find_by_email(email)
    user.present? ? user : nil
  end

  # 设置session
  #
  # ping.wang
  def set_session
    %w(id email name).each {|i| session[i.to_sym] = @user[i] if @user[i].present? }
  end
end
