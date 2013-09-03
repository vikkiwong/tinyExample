# encoding: UTF-8
class Auction::CustomersController < ApplicationController

  #展示2013年有过成功订单的用户的信息列表
  def index
    @customers = []
    customer_ids = Auction::Trade.find_success_trade_users
    customer_ids.each do|customer_id|
      customer = Auction::Customer.find_by_id(customer_id)
      if customer.present?
        hots = Auction::Contact.hots_contact_info(customer_id)
        customer.hots_contact_province, customer.hots_contact_city, customer.hots_contact_mobile = hots["hots_contact_province"], hots["hots_contact_city"], hots["hots_contact_mobile"]
        @customers << customer if customer.present?
      end
    end
  end
end
