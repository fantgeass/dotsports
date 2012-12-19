module Spree
  module Search
    class Dotsports < Spree::Search::Base

      def retrieve_products
        @products_scope = get_base_scope
        curr_page = page || 1

        @products = @products_scope.includes([:master]).page(curr_page).per(per_page)

        @products = scope_products_by_price(@products)

        @products = @products.with_rating(1) if @properties[:rating].present?

        if @properties[:taxons]
          p = []
          @properties[:taxons].each do |taxon|
            p += @products.in_taxon(Taxon.find(taxon))
          end
          @products = p.uniq
        end

        @products
      end

      protected
        def get_base_scope
          Product.active
        end

        def prepare(params)
          @properties[:search] = params[:search]
          @properties[:taxon] = params[:taxon].blank? ? nil : Taxon.find(params[:taxon])
          @properties[:rating] = params[:rating]
          @properties[:taxons] = params[:taxons].blank? ? nil : params[:taxons]
          @properties[:price_min], @properties[:price_max] = parse_price(params[:price]).first
          @properties[:price_max] = parse_price(params[:price]).last
          @properties[:page] = (params[:page].to_i <= 0) ? 1 : params[:page].to_i
        end

        def scope_products_by_price(products)
          if @properties[:price_min].present? || @properties[:price_max].present?
            min = @properties[:price_min].blank? ? 1 : @properties[:price_min]
            max = @properties[:price_max].blank? ? 1 << 32 : @properties[:price_max]
            products = @products.price_between(min, max)
          end
          products
        end

        def parse_price(price)
          (price.present? ? price : '-').split('-', -1)
        end
    end
  end
end
