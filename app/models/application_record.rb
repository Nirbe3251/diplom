class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.humanize(locale = :ru)
    I18n.t "#{name.underscore}.name", locale:
  end

  def humanize(_locale = :ru)
    self.class.humanize
  end
end
