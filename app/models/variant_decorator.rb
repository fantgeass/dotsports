Variant.class_eval do 
  after_create { self.sku = self.id; save! }
end
