class Admin::SuppliersController < Admin::ResourceController

  def index
    respond_with(@collection)  
  end

  def show
    respond_with(@supplier)
  end

  protected

  def collection
    @search = Supplier.metasearch(params[:search] || {})
    @collection = @search.page(params[:page]).per(Spree::Config[:per_page])
  end

end
