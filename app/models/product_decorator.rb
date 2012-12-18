Product.class_eval do
  has_one :product_extension
  accepts_nested_attributes_for :product_extension, :allow_destroy => true
  delegate_belongs_to :product_extension, :old_price, :embedded_video

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

  def self.with_rating(rating)
    self.where(:avg_rating => rating)
  end
end
