Taxonomy.class_eval do

  def self.sortable_taxonomies
    sortables = %w(Брэнд Уровень\ подготовки)
    Taxonomy.where(:name => sortables)
  end

end
