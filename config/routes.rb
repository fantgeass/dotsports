Dotsports::Application.routes.draw do
  
  match 'products/alphabet/:name_begins_with' => 'products#alphabet', :as => 'products_by_alphabet'

end
