class LinkItem
  include Listable
  attr_reader :description, :site_name

  def initialize(url, options={})
    @description = url
    @site_name = options[:site_name]
  end
  def self.type
    "link"
  end
  def format_name
    @site_name ? @site_name : ""
  end
  def details
    [self.class.type, format_description(@description),  "site name: " + format_name]
  end
end
