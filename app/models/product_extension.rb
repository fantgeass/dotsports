class ProductExtension < ActiveRecord::Base
  belongs_to :product, :class_name => "Product"
  attr_accessible :old_price
end
