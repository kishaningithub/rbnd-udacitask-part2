class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = if options[:title].nil? then "Untitled List" else options[:title] end
    @items = if options[:items].nil? then [] else options[:items] end
  end
  def add(type, description, options={})
    type = type.downcase
    initLength = @items.length
    @items.push TodoItem.new(description, options) if type == TodoItem.type
    @items.push EventItem.new(description, options) if type == EventItem.type
    @items.push LinkItem.new(description, options) if type == LinkItem.type
    finalLength = @items.length
    raise UdaciListErrors::InvalidItemType if initLength == finalLength
  end
  def delete(index)
    raise UdaciListErrors::IndexExceedsListSize if @items.delete_at(index - 1).nil?
  end
  def delete_by_type(item_type)
    @items.delete_if{|item| item.class.type == item_type}
  end
  def change_priority(index, priority)
    item = @items[index - 1]
    raise UdaciListErrors::IndexExceedsListSize if item.nil?
    if item.class == TodoItem then
      item.change_priority(priority)
    end
  end
  def all
    rows = @items.map.with_index {|item, i| [i + 1] + item.details}.to_a
    output = Terminal::Table.new :title => @title, :rows => rows
    puts output
  end
  def filter(item_type)
    filtered_list = @items.select{|item| item.class.type == item_type}
    if filtered_list.empty? then
      puts "No items of type #{item_type}"
    else
      filtered_udacilist = UdaciList.new(title: self.title, items:filtered_list)
      puts filtered_udacilist.all
    end
    filtered_udacilist
  end
end
