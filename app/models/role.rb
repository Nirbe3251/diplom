class Role < ApplicationRecord
  NAMES = {
    create_test_case: 'Создание тест-кейсов',
    create_check_list: 'Создание чек-листов',
    create_test_plan: 'Создание тест-планов',
    create_bug_report: 'Создание баг-репортов'
  }.freeze

  Role.column_names.dup.delete_if { |n| /^id$/ =~ n || /^name$/ =~ n }.each do |column_name|
    define_method "#{column_name}_show_data" do
      self[column_name] == 1 ? 'Да' : 'Нет'
    end
  end
end
