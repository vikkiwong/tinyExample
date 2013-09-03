#该model对应244服务器上data_ihaveu_com_development中的auction_trade，在config/initializers/multi_dataset中配置了IhaveuRecord
class Auction::Trade < IhaveuRecord
  self.table_name = 'auction_trades'


  #搜索2013年有过成功订单信息的用户
  #
  #wangyang.shen
  def self.find_success_trade_users
    year = 2013
    sql = <<-SQL
      SELECT DISTINCT(t.user_id) as user_id
      FROM auction_trades AS t
      INNER JOIN auction_trades_updatings AS tu
      ON tu.trade_id = t.id and tu.status='receive'
      WHERE t.delivery_service is NOT NULL AND t.delivery_service!= ''
      AND t.status in ('complete','receive') AND YEAR(t.created_at) = #{year}
    SQL
    result = IhaveuRecord.connection.execute(sql)
    result.present?? result.collect{|r| r[0] } : ""
  end

end