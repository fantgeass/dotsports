ProductsController.class_eval do
  def alphabet
    @searcher = Spree::Config.searcher_class.new(params)
    @products = @searcher.retrieve_products
    respond_with(@products)
  end

  private

  def accurate_title
    @product ? @product.default_meta_description : super
  end
end