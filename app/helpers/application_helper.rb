module ApplicationHelper
  # 转换时间显示格式
  def shown_time(cur_time)
    if cur_time.is_a?(Time)
      cur_time.strftime("%Y-%m-%d %H:%M")
    else
      ""
    end
  end

  # 转换时间显示格式
  def shown_date(cur_time)
    if cur_time.is_a?(Time)
      cur_time.strftime("%Y-%m-%d")
    else
      ""
    end
  end


  def role_str(role)
    str = User::ROLES.find{ |i| i.last == role }
    str.present? ? str.first : ""
  end
end
