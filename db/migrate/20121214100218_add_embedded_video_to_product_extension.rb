class AddEmbeddedVideoToProductExtension < ActiveRecord::Migration
  def change
    add_column :product_extensions, :embedded_video, :text
  end
end
