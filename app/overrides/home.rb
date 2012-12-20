Deface::Override.new(:virtual_path => "home/index",
  :insert_before => "[data-hook='homepage_products']",
  :partial => "shared/filter",
  :name => "filter")
