# 这是一个rake任务，rake send_info_email
#
# wangyang.shen  2013-09-06
task :send_info_email => :environment do
  Auction::Trade.send_info_mail
end

