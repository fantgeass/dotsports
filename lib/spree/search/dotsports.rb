module Spree
  module Search
    class Dotsports < Spree::Search::Base

      def retrieve_products
        @products_scope = get_base_scope
        current_page = page || 1

        @products = @products_scope.includes([:master]).page(current_page).per(per_page)

        @products = scope_products_by_price(@products)

        @products = @products.with_rating(@properties[:rating]) if @properties[:rating].present?

        @products = @products.where('products.name like ?', "#{@properties[:name_begins_with]}%") if @properties[:name_begins_with]

        @products = @products.filter_by_brand_ids(@properties[:brands]) if @properties[:brands]

        # if @properties[:taxons]
        #   pr = []
        #   @properties[:taxons].each do |taxon|
        #     pr += @products.in_taxon(Taxon.find(taxon))
        #   end
        #   @products = pr.uniq
        # end

        @products
      end

      def brands
        Taxonomy.brand.taxons if Taxonomy.brand
      end

      def difficulties
        Taxonomy.difficulty.taxons if Taxonomy.difficulty
      end


      protected

        def get_base_scope
          Product.active
        end

        def prepare(params)
          @properties[:search] = params[:search]
          @properties[:taxon] = params[:taxon].blank? ? nil : Taxon.find(params[:taxon])
          @properties[:rating] = params[:rating]
          @properties[:brands] = params[:brands].blank? ? nil : params[:brands]
          @properties[:difficulties] = params[:difficulties].blank? ? nil : params[:difficulties]
          @properties[:price_min], @properties[:price_max] = parse_price(params[:price]).first
          @properties[:price_max] = parse_price(params[:price]).last
          @properties[:page] = (params[:page].to_i <= 0) ? 1 : params[:page].to_i
          @properties[:name_begins_with] = params[:name_begins_with]
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
