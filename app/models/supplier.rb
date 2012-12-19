class Supplier < ActiveRecord::Base

  OWNERSHIP_TYPES = ['juridical', 'ie']
  
  validates :name, :presence => true

  validates :ownership_type, :inclusion => OWNERSHIP_TYPES, :allow_blank => true

end
