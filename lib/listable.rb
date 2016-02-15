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
    value = " ⇧".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:blue) if priority == "medium"
    value = " ⇩".colorize(:yellow) if priority == "low"
    value = "" if !priority
    return value
  end
end
