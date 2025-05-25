class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :roles, class_name: 'Role', optional: true

  has_many :project_users, class_name: 'ProjectUser'
  has_many :projects, through: :project_users, dependent: :destroy

  validates :name, :surname, presence: true

  def full_name
    "#{surname} #{name}"
  end
end
