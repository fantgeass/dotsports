Taxon.class_eval do

  def self.for_filter(taxonomy_id)
    self.where("taxonomy_id = ? AND parent_id IS NOT NULL", taxonomy_id)
  end

end