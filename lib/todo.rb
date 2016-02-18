class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    validate_priority @priority
  end
  def self.type
    "todo"
  end
  def validate_priority(priority)
    raise UdaciListErrors::InvalidPriorityValue if format_priority(priority).nil?
  end
  def change_priority(priority)
    validate_priority(priority)
    @priority = priority
  end
  def details
    [self.class.type, format_description(@description), "due: " +
    format_date(@due, nil, "No due date") +
    format_priority(@priority)]
  end
end
