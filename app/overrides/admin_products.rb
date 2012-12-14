Deface::Override.new(:virtual_path => "admin/products/_form",
  :replace => "[data-hook='admin_product_form_right']",
  :partial => "admin/products/edit_form_right",
  :name => "admin_products_edit_form_right")
