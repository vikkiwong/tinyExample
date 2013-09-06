require 'rubygems'
require 'rufus/scheduler'
require 'eventmachine'
require [File.dirname(__FILE__), 'tiny_schedulers_env.rb'].join("/")
command = "cd #{RAILS_ROOT_PATH} && #{RUBY_PATH} #{RAKE_PATH}"
EM.run {
  scheduler = Rufus::Scheduler::EmScheduler.start_new

  #定时发送邮件
  scheduler.cron '00 10 * * MON' do
    `#{command} tiny:send_info_email #{RAILS_ENV}`
  end
}

