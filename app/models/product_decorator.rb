Product.class_eval do
  has_one :product_extension
  accepts_nested_attributes_for :product_extension, :allow_destroy => true
  delegate_belongs_to :product_extension, :old_price, :embedded_video

  belongs_to :supplier

  def meta_description
    attributes['meta_description'].presence || default_meta_description
  end

  def default_meta_description
    taxon = taxons.order(:permalink).where('permalink like "cat/%"').first || taxons.first
    I18n.t(:product_default_meta_description, :product => name, :taxon => (taxon.name unless taxon.nil?))
  end

  def [](attr_name)
    attr_name == :meta_description ? meta_description : super
  end

  class << self
    def with_rating(rating)
      self.where(:avg_rating => rating)
    end

    def filter_by_brand_ids(brand_ids)
      joins('INNER JOIN products_taxons AS products_brands ON products_brands.product_id = products.id').
      joins('INNER JOIN taxons as brands ON products_brands.taxon_id = brands.id').
      where(:brands => {:id => brand_ids, :taxonomy_id => Taxonomy.brand}) 
    end

    def filter_by_difficulty_ids(difficulty_ids)
      joins('INNER JOIN products_taxons AS products_difficulties ON products_difficulties.product_id = products.id').
      joins('INNER JOIN taxons as difficulties ON products_difficulties.taxon_id = difficulties.id').
      where(:difficulties => {:id => difficulty_ids, :taxonomy_id => Taxonomy.difficulty}) 
    end

  end

end
