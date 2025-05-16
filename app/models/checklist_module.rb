class ChecklistModule < ApplicationRecord
  belongs_to :checklist
  has_many :module_check

  def self.create_module_block(params, checklist_id)
    Rails.logger.info "Checklist params #{__method__} #{params}, checklist module: #{checklist_id}"
    module_key = params[:modules]
    module_key.each_key do |k|
      module_parameters = module_key.delete(k)
      if find_by(position: k.to_i, checklist_id:)
        new_module = find_by(position: k.to_i, checklist_id:)
        new_module.update(name: module_parameters[:name])
      else
        new_module = create(position: k.to_i, name: module_parameters[:name], checklist_id:)
      end
      Rails.logger.info "Created module: #{new_module.inspect}"
      ModuleCheck.create_checklists(new_module.id, module_parameters[:checklist])
    end
  rescue StandardError => e
    Rails.logger.error "Create #{__method__} #{e.message}, #{e.backtrace}"
  end
end
