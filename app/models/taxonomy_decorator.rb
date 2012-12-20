Taxonomy.class_eval do
  class << self
    def brand
      where(:name => BRAND_TAXON_NAME).first
    end

    def difficulty
      where(:name => DIFFICULTY_TAXON_NAME).first
    end
  end
end
