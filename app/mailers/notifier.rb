# encoding: utf-8
class Notifier < ActionMailer::Base
  self.default(
      :from                      => "#{SETTINGS["name"]} <#{SETTINGS["email"]}>" ,
      :charset                   => "UTF-8",
      :content_transfer_encoding => "7bit",
      :content_type              => "text/html"
  )

  self.smtp_settings = {
      :address                   => SETTINGS["address"],
      :domain                    => SETTINGS["domain"],
      :enable_starttls_auto      => SETTINGS["enable_starttls_auto"],
      :authentication            => SETTINGS["authentication"],
      :port                      => SETTINGS["port"]
  }

  #发送邮件
  #:to 收件人
  #:subject 邮件标题
  #:cc 抄送
  #:bcc 密送
  def send_info_mail(users,results)
    @results = results
    @mail_to = users.collect{|c| %Q("#{c.name}"<#{c.email}@ihaveu.net>)}
    mail :to => @mail_to , :subject => '2013系统测试邮件'
  end

end
