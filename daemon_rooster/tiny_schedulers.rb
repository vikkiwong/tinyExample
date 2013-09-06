require 'rubygems'
require 'rufus/scheduler'
require 'eventmachine'
require [File.dirname(__FILE__), 'tiny_schedulers_env.rb'].join("/")
command = "cd #{RAILS_ROOT_PATH} && #{RUBY_PATH} #{RAKE_PATH}"
EM.run {
  scheduler = Rufus::Scheduler::EmScheduler.start_new

  #定时发送邮件
  #执行任务输入 ruby daemon_rooster/daemon_runner.rb start 若要关闭最后改成stop
  #scheduler.every '10s' do   #此行可以进行测试
  scheduler.cron '00 10 * * MON' do
    `#{command} tiny:send_info_email #{RAILS_ENV}`
  end
}

