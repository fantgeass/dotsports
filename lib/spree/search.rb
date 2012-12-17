module Spree::Search
  Base.class_eval do

    spree_prepare = instance_method(:prepare)
    spree_get_base_scope = instance_method(:get_base_scope)

    define_method :prepare do |params|
      spree_prepare.bind(self).call(params)
      @properties[:name_begins_with] = params[:name_begins_with]
    end

    define_method :get_base_scope do
      base_scope = spree_get_base_scope.bind(self).call
      base_scope = base_scope.where('products.name like ?', "#{@properties[:name_begins_with]}%") if @properties[:name_begins_with]
      base_scope
    end
  end
end