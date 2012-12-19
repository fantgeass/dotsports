Deface::Override.new(
  :virtual_path => "layouts/admin",
  :name => "admin_suppliers_tab",
  :insert_bottom => "[data-hook='admin_tabs']",
  :text => "<%= tab(:suppliers) %>")