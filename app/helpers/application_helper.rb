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

      controller_const = "#{controller.camelize}Controller".constantize
      localize_name = controller_const.humanize

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

  def path_to_test_case(test_case)
    test_case_id = test_case.id
    id = TestSuite.find_by(title: test_case.test_module).id
    show_test_case_path(id:, test_case_id:)
  end

  def release_tc_status(test_case, release_id)
    status = TestCaseStatus.where('test_case_id = ?', test_case.id)
    if status.present?
      release_status = status.find_by(release_id:)
      if release_status.present?
        if release_status.completed?
          'success-status'
        else
          'error-status'
        end
      else
        ''
      end
    else
      ''
    end
  end
end
