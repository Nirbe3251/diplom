class AddAttachments < ActiveRecord::Migration[7.0]
  def up
    create_table :attachments do |t|
      t.text :description, limit: 80
      t.string :file_name
      t.blob :file
    end
  end

  def down
    drop_table :attachments
  end
end
