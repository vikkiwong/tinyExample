# encoding: UTF-8
class Auction::UsersController < ApplicationController

  #展示有过成功订单的用户的信息列表
  def index
    @year = 2013
    users_info = Auction::Trade.find_success_trade_users(@year)
    @users = Auction::User.paginate(:page => params[:page]).find_all_by_id(users_info.collect{|user| user[0] })
    @users.each do|user|
      user_info = users_info.find{|user_info| user_info[0].to_i == user.id.to_i}
      user.lt_trade_id = user_info[1]
      user.lt_trade_date = user_info[2]
    end
  end
end
