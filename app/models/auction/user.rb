class Auction::User < IhaveuRecord
  self.table_name = 'auction_users'

  #lt_trade_date 最近成功订单日期
  #lt_trade_id 最近成功订单ID
  #虚拟属性
  attr_accessor :lt_trade_date, :lt_trade_id
end