#encoding: utf-8
class User < ActiveRecord::Base
  attr_accessible :id, :name, :email, :role
  cattr_accessor :current_user

  ROLES = [
    ['普通用户', 'member'],
    ['管理员', 'manager']
  ]

  #判断用户是否是role角色
  # == params ===
  # role(String):: 角色名
  #
  # == return ===
  # true/false
  #
  # zhanghong
  # 2012-07-11
  def is?(role)
    self.role == role.to_s
  end

  private
  # 查找用户表中是否有目标用户，并验证公司邮箱密码
  # === Params ====
  # email(string)，password(string)
  # ===  Return ===
  # 用户 or nil
  # 
  # ping.wang  2013.08.23
  def self.check_user(email, password)
    return nil if !email
    user = where(:email => email).first
    user && sign_up(email, password) ? user : nil
  end

  # 验证公司邮箱和密码是否匹配
  # === Params ====
  # email(string)，password(string)
  # ===  Return ===
  # Boolean
  # 
  # ping.wang 2013.08.23
  def self.sign_up(email, password)
    return nil if !email
    ldap = Net::LDAP.new
    ldap.host = "mail.ihaveu.net"
    ldap.port = 389
    ldap.auth "uid=#{email},ou=people,dc=ihaveu,dc=net", "#{password}"
    ldap.bind
  end
end
