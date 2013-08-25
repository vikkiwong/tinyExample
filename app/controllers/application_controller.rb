class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :login_check


  # 登陆验证方法, 如果未登陆，记住当前访问地址
  # 
  # ping.wang
  # 2013.08.23
  def login_check
    if session[:id].blank? # 记住登录前访问的路径
      session[:back_path] = request.fullpath unless request.format.json?
      redirect_to("/login") and return
    end
  end
end
