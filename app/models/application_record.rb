class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.humanize(locale = :ru)
    I18n.t "#{name.underscore}.name", locale:
  end

  def humanize(locale = :ru)
    self.class.humanize(locale)
  end

  def self.downcase
    name.underscore
  end

  def downcase
    self.class.downcase
  end
end
