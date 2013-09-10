#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :login_check

  before_filter do |c|
    p "---"*30
    User.current_user = User.find(c.session[:id]) unless c.session[:id].nil?
  end

  #cancan插件用户权限验证失败处理方法
  #
  # zhanghong
  # 2012-07-11
  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = "对不起，你没有权限进行该操作！"
    redirect_to(root_path)
  end

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
private
  def current_ability
    begin
      @current_user = @current_user || User.current_user || User.find(session[:id])
      @current_ability ||= Ability.new(@current_user)
    rescue
      redirect_to("/login") and return
    end
  end
end
