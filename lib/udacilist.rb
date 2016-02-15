class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @title = "Untitled List" if @title.nil?
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    initLength = @items.length
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
    finalLength = @items.length
    raise UdaciListErrors::InvalidItemType if initLength == finalLength
  end
  def delete(index)
    raise UdaciListErrors::IndexExceedsListSize if @items.delete_at(index - 1).nil?
  end
  def all
    rows = @items.map.with_index {|item, i| [i + 1] +   item.details}.to_a
    output = Terminal::Table.new :title => @title, :rows => rows
    puts output
  end
end
