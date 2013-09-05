#该model对应244服务器上data_ihaveu_com_development中的auction_trade，在config/initializers/multi_dataset中配置了IhaveuRecord
class Auction::Trade < IhaveuRecord
  self.table_name = 'auction_trades'


  #搜索有过成功订单信息的用户
  #
  #wangyang.shen
  def self.find_success_trade_users(year)
    sql = <<-SQL
      SELECT user_id , trade_id, trade_created_at
      FROM  ( SELECT t.user_id as user_id, t.id as trade_id, t.created_at as trade_created_at
      FROM auction_trades AS t
      INNER JOIN auction_trades_updatings AS tu
      ON tu.trade_id = t.id and tu.status='receive'
      WHERE t.delivery_service is NOT NULL AND t.delivery_service!= ''
      AND t.status in ('complete','receive') AND YEAR(t.created_at) = 2013
	    ORDER BY t.id DESC ) AS c
      GROUP BY c.user_id
    SQL
    IhaveuRecord.connection.execute(sql)
  end

end