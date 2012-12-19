Deface::Override.new(
  :virtual_path => "admin/shared/_product_tabs",
  :name => "asas",
  :insert_top => "[data-hook='admin_product_tabs']",
  :partial => "admin/shared/product_preview_link",
  :disabled => false)

Deface::Override.new(
  :virtual_path => "layouts/admin",
  :name => "suppliers_admin_tab",
  :insert_bottom => "[data-hook='admin_tabs']",
  :text => "<%= tab(:suppliers) %>")
