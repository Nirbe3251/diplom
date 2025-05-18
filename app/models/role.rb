class Role < ApplicationRecord
  has_many :users, foreign_key: :roles_id

  validates :name, presence: true

  NAMES = {
    create_test_case: 'Создание тест-кейсов',
    edit_test_case: 'Редактирование тест-кейсов',
    remove_test_case: 'Удаление тест-кейсов',

    create_check_list: 'Создание чек-листов',
    edit_checklist: 'Редактирование чек-листов',
    remove_checklist: 'Удаление чек-листов',

    create_test_plan: 'Создание планов тестирования',
    edit_test_plan: 'Редактирование планов тестирования',
    remove_test_plan: 'Удаление планов тестирования',

    create_bug_report: 'Создание отчетов об ошибках',
    edit_bug_report: 'Редактирование отчетов об ошибках',
    remove_bug_report: 'Удаление отчетов об ошибках'
  }.freeze

  Role.column_names.dup.delete_if { |n| /^id$/ =~ n || /^name$/ =~ n }.each do |column_name|
    define_method "#{column_name}_show_data" do
      text = if self[column_name] == 1
               '<i class="fa fa-check-circle-o green"></i>Да'
             else
               '<i class="fa fa-cross-circle text-danger"></i>Нет'
             end.html_safe

      text
    end
  end
end
