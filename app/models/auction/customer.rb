class Auction::Customer < IhaveuRecord
  self.table_name = 'auction_users'

  #hots_contact_province 常用收货省
  #hots_contact_city 常用收货市
  #hots_contact_mobile 常用收货手机号
  #虚拟属性
  attr_accessor :hots_contact_province, :hots_contact_city ,:hots_contact_mobile

  #mobile 注册手机号
  #
  #wangyang.shen
  def mobile
    sql= <<-SQL
     SELECT IFNULL(a.phone, '') AS mobile
     FROM core_accounts AS a
     WHERE a.id = #{self.id}
    SQL
    IhaveuRecord.connection.execute(sql).first[0]
  end

end