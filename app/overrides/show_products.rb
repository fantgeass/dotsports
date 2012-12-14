Deface::Override.new(:virtual_path => "products/_cart_form",
  :insert_before => "[data-hook='product_price']",
  :partial => "products/show_old_price",
  :name => "product_old_price")
