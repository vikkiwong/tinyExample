module ApplicationHelper
  def shown_time(cur_time)
    if cur_time.is_a?(Time)
      cur_time.strftime("%Y-%m-%d %H:%M")
    else
      ""
    end
  end

  def shown_date(cur_time)
    if cur_time.is_a?(Time)
      cur_time.strftime("%Y-%m-%d")
    else
      ""
    end
  end
end
