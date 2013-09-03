# Ihaveu
class IhaveuRecord < ActiveRecord::Base
  self.abstract_class = true
  establish_connection("ihaveu_#{Rails.env}")
end