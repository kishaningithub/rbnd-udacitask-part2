module Listable
  def format_description(description)
      "#{description}".ljust(30)
  end
  def format_date(date1, date2, msgIfNull)
      date = ""
      date << date1.strftime("%D") if date1
      date << " -- " + date2.strftime("%D") if date2
      date = msgIfNull if date.empty?
      date
  end
  def format_priority(priority)
    value = " ⇧" if priority == "high"
    value = " ⇨" if priority == "medium"
    value = " ⇩" if priority == "low"
    value = "" if !priority
    return value
  end
  def validate_priority(priority)
    raise UdaciListErrors::InvalidPriorityValue if format_priority(priority).nil?
  end
end
