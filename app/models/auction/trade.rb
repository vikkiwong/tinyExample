#该model对应244服务器上data_ihaveu_com_development中的auction_trade，在config/initializers/multi_dataset中配置了IhaveuRecord
class Auction::Trade < IhaveuRecord
  self.table_name = 'auction_trades'


  # 按条件统计某年有过成功订单的用户信息（id，name，最近成功订单id，最近成功订单日期）
  #
  # wangyang.shen 2013.09.05
  def self.find_success_trade_users(year)
    sql = <<-SQL
      SELECT user_id , au.name as user_name, trade_id, trade_created_at
      FROM  (
              SELECT t.user_id as user_id, t.id as trade_id, t.created_at as trade_created_at
              FROM auction_trades AS t
              INNER JOIN auction_trades_updatings AS tu
              ON tu.trade_id = t.id and tu.status='receive'
              WHERE t.delivery_service is NOT NULL AND t.delivery_service!= ''
              AND t.status in ('complete','receive') AND YEAR(t.created_at) = #{year}
              ORDER BY t.id DESC 
            ) AS c
      LEFT JOIN auction_users AS au ON au.id = c.user_id
      GROUP BY c.user_id
    SQL
    self.find_by_sql(sql)
  end

  # 发送用户信息邮件方法
  #
  # wangyang.shen 2013.09.06
  def self.send_info_mail
    year = 2013
    results = self.find_success_trade_users(year)
    # 出现错误抛出异常，防止出现无效邮箱导致发送邮件失败
    begin
      Notifier.send_info_mail(User.all,results).deliver if User.all.present? && results.present?
    rescue Exception => e
      puts e.message
    end
  end
end