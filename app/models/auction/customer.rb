class Auction::Customer < IhaveuRecord
  self.table_name = 'auction_users'

  #hots_contact_province 常用收货省
  #
  #wangyang.shen
  def hots_contact_province
    Auction::Contact.hots_contact_info(self.id)["hots_contact_province"]
  end

  #hots_contact_city 常用收货市
  #
  #wangyang.shen
  def hots_contact_city
    Auction::Contact.hots_contact_info(self.id)["hots_contact_city"]
  end

  #hots_contact_mobile 常用收货手机号
  #
  #wangyang.shen
  def hots_contact_mobile
    Auction::Contact.hots_contact_info(self.id)["hots_contact_mobile"]
  end

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