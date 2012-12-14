Product.class_eval do
  has_one :product_extension
  accepts_nested_attributes_for :product_extension, :allow_destroy => true
  delegate_belongs_to :product_extension, :old_price
  attr_accessible :old_price
end
