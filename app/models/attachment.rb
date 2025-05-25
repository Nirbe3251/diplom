class Attachment < ApplicationRecord
  belongs_to :bugreport, foreign_key: :bugreport, optional: true

  def self.save_attachments(files, bugreport_id: nil)
    return unless files.present?

    files.each do |file|
      tmp = file.tempfile
      orig = file.original_filename
      orig.gsub!(' ', '_')
      orig.gsub!(/[^0-9a-zA-Zа-яА-Я._-]+/i, '')
      new_file = File.join("storage/bugreports/#{bugreport_id}", orig)
      FileUtils.mkdir_p(Pathname.new(new_file).dirname.to_s)
      FileUtils.mv tmp.path, new_file
      `chown 1000:1000 "#{new_file}"`
      `chmod 0664 "#{new_file}"`
      create(bugreport_id:, file_name: orig, file_path: new_file, file_ext: orig.split('.').last)
    end
  end

  def generate_link
    absolute_path = Pathname.new(file_path).dirname.to_s
    "https://0.0.0.0:3000/#{absolute_path}/#{CGI.escape(file_name)}"
  end
end
