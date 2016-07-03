module ApplicationHelper
  # def title(page_title)
  #   content_for :title, page_title.to_s
  # end
  def full_title(page_title)
    base_title = t(:site_name)
    if page_title.empty?
      base_title
    else
      "#{base_title} + ' ' + t(:site_name)"
    end
  end
  
  def nav_bar
    content_tag(:ul, class: "nav navbar-nav") do
      yield
    end
  end
  
  def nav_bar_right
    content_tag(:ul, class: "nav navbar-nav navbar-right") do
      yield
    end
  end
  
  def nav_link(text, path)
    options = current_page?(path) ? { class: "active" } : {}
    content_tag(:li, options) do
      link_to text, path
    end
  end
end
