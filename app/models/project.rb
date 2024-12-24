class Project < ApplicationRecord
  has_many :project_users, class_name: 'ProjectUser'
  has_many :users, through: :project_users, dependent: :destroy

  before_create do |_p|
    users << User.find(user_id)
  end

  def excluded_users
    User.all - users
  end
end
