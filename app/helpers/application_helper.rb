module ApplicationHelper
  def select_controllers
    Rails.application.routes.routes.map do |route|
      action = route.defaults[:action]
      path = route.path.spec.to_s.dup
      controller = route.defaults[:controller]
      next if path == '/'
      next if /(rails|action_mailbox|active_storage|turbo|devise)/ =~ controller
      next if action != 'index'
      next if /(:id)/ =~ path

      localize_name = controller

      controller = controller.camelize
      path.gsub!(/\(\.:format\)/, '')

      { controller:, path:, localize_name: }
    end.uniq.compact
  end

  def current_page
    "#{request[:controller].camelize}Controller".constantize.page_head
  end

  def generate_delete_button(object)
    render partial: 'helpers/delete_button', locals: { object: }
  end
end
