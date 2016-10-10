#:nodoc: all
module DeviseHelper
# def devise_error_messages!
#    return "" unless devise_error_messages?
#
#    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
#    sentence = I18n.t("errors.messages.not_saved",
#                      :count => resource.errors.count,
#                      :resource => resource.class.model_name.human.downcase)
#
#    html = <<-HTML
#    <div id="error_explanation">
#      <h2>#{sentence}</h2>
#      <ul>#{messages}</ul>
#    </div>
#    HTML
#
#    html.html_safe
#  end
#
#  def devise_error_messages?
#    !resource.errors.empty?
#  end
def devise_error_messages!
    return '' if resource.errors.empty?
    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
   <div class="alert alert-danger danger-block alert-text" role="alert">
   <button type="button" class="close" data-dismiss="alert">
    <span class="glyphicon glyphicon-remove-circle"></span>
   </button>
    <h4>#{sentence}</h4>
    <ul>
      #{messages}
    </ul>
   </div>
   HTML

    html.html_safe
  end

  def devise_error_messages?
    flash_messages
  end
end
