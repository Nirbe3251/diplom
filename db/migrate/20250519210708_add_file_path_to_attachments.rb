class AddFilePathToAttachments < ActiveRecord::Migration[7.0]
  def up
    add_column :attachments, :file_path, :text
    add_column :attachments, :file_ext, :string
    add_column :attachments, :bugreport_id, :integer, null: true, index: true, foreign_key: true
  end

  def down
    remove_column :attachments, :file_path
    remove_column :attachments, :file_ext
    remove_column :attachments, :bugreport_id
  end
end
