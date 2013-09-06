
namespace :tiny do
#发送测试邮件
#
#wangyang.shen
#2013-09-06
  task :send_info_email => :environment do
    Auction::Trade.send_info_mail
  end
end
