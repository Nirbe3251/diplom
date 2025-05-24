class ModuleCheck < ApplicationRecord
  belongs_to :checklist_module

  def self.create_checklists(module_id, checklist_params)
    Rails.logger.info "ModuleCheck params #{checklist_params}, checklist module: #{module_id}"
    checklist_params.each do |position, params|
      Rails.logger.info "POSITION #{position}"
      module_step = params[:text]
      expected_result = params[:expected_result]
      if find_by(checklist_module_id: module_id, position:)
        check = find_by(checklist_module_id: module_id, position:)
        check.update(position:, module_step:, expected_result:)
      else
        check = create(position:, module_step:, checklist_module_id: module_id, expected_result:)
      end
      Rails.logger.info "Created check #{check}"
    end
  rescue StandardError => e
    Rails.logger.error "Create #{__method__} #{e.message}, #{e.backtrace}"
  end
end
