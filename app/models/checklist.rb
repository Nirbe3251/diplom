class Checklist < ApplicationRecord
  belongs_to :project
  has_many :checklist_module

  DEFAULT_ATTRS = %i[head project_id test_type].freeze

  def self.create_checklist(params)
    Rails.logger.info "Create checklist params #{params}"
    default = params.select do |k, _v|
      Rails.logger.info "Param: #{k}"
      DEFAULT_ATTRS.include?(k.to_sym)
    end

    new_checklist = create(default)

    if new_checklist.errors.present?
      Rails.logger.error "Error in #{__method__} with errors: #{new_checklist.errors.full_messages.join(', ')}"
    end

    ChecklistModule.create_module_block(params[:checklists], new_checklist.id)

    new_checklist
  end

  def update_checklist(params)
    default = params.select do |k, _v|
      Rails.logger.info "Param: #{k}"
      DEFAULT_ATTRS.include?(k.to_sym)
    end

    update(default)

    Rails.logger.error "Error in #{__method__} with errors: #{errors.full_messages.join(', ')}" if errors.present?

    ChecklistModule.create_module_block(params[:checklists], id)

    self
  end
end
