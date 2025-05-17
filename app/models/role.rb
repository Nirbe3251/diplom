class Role < ApplicationRecord
  has_many :users, foreign_key: :roles_id

  validates :name, presence: true

  NAMES = {
    create_test_case: 'Создание тест-кейсов',
    create_check_list: 'Создание чек-листов',
    create_test_plan: 'Создание тест-планов',
    create_bug_report: 'Создание баг-репортов'
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
