class ApplicationRecord < ActiveRecord::Base
  def attributes_protected_by_default
    ['type']
  end
  self.abstract_class = true
end
