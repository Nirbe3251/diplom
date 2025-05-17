# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
%w[Нормальный Средний Высокий Высший].each_with_index do |name, index|
  Priority.create(title: name, priority_level: index)
end

%w[Блокирующая Критическая Значительная Незначительная Тривиальная].each_with_index do |name, index|
  Severity.create(title: name, severity_level: index)
end
