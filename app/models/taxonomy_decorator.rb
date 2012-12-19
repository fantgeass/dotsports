Taxonomy.class_eval do

  def self.sortable_taxonomies
    _sortable_taxonomies = [1, 2]
    Taxonomy.where(:id => _sortable_taxonomies)
  end

end