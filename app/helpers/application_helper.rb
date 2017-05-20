module ApplicationHelper
  def nav_item(tag=:div, options={}, &block)
    classes = [options[:class], "nav-item"].compact
    content_tag tag, options.merge(class: classes), &block
  end
end
