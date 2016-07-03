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
end
