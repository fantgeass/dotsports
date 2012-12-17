class ProductExtension < ActiveRecord::Base
  belongs_to :product, :class_name => "Product"
end
