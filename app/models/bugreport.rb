class Bugreport < ApplicationRecord
  self.table_name = 'bug_reports'

  belongs_to :project
  belongs_to :severity, optional: true
  belongs_to :priority, optional: true
  belongs_to :status, optional: true

  validates :title, presence: true

  has_many :attachments

  def self.search(params)
    res = all

    res = res.where(performer_id: params[:performer_id]) if params[:performer_id].present?

    res
  end

  def performer
    User.find_by(id: performer_id)&.name
  end
end
