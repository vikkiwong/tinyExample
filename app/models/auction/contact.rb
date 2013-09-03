class Auction::Contact < IhaveuRecord
  self.table_name = 'auction_contacts'

  #计算常用收货信息
  #
  #wangyang.shen
  def self.hots_contact_info(user_id)
    info = {}
    where_conditions = <<-COND
      t.user_id=#{user_id}  AND t.delivery_service is not null AND t.delivery_service!='' AND
      EXISTS (SELECT up.id FROM auction_trades_updatings up WHERE up.trade_id=t.id AND up.status='receive')
    COND
    log = Auction::Contact.select("auction_contacts.id").joins("INNER JOIN auction_trades t ON auction_contacts.id=t.contact_id").
        where(where_conditions).group("auction_contacts.id").
        order("COUNT(*) DESC, MAX(t.id) DESC").first
    if log.present?
      id = log.id
      hot_contact = Auction::Contact.find(id)
      if hot_contact.present?
        info["hots_contact_mobile"] = hot_contact.mobile
        info["hots_contact_province"] = hot_contact.province
        info["hots_contact_city"] = hot_contact.city
      end
    end
    info
  end

end