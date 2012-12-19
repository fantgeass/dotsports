Deface::Override.new(:virtual_path => "admin/products/_form",
  :replace => "[data-hook='admin_product_form_right']",
  :partial => "admin/products/edit_form_right",
  :name => "admin_products_edit_form_right")

Deface::Override.new(
  :virtual_path => "admin/shared/_product_tabs",
  :name => "admin_products_preview_link",
  :insert_top => "[data-hook='admin_product_tabs']",
  :partial => "admin/products/preview_link")

Deface::Override.new(
  :virtual_path => "admin/products/index",
  :name => "admin_products_index_search_supplier",
  :insert_bottom => "[data-hook='admin_products_index_search']",
  :partial => "admin/products/index_search_supplier")