class CambiosVideosUpload < ActiveRecord::Migration
  def change
  	add_column :videos, :attach_file_name, :string
  	add_column :videos, :attach_content_type, :string
  	add_column :videos, :attach_file_size, :integer
  	add_column :videos, :attach_updated_at, :datetime
  	remove_column :videos, :nombre
  	remove_column :videos, :fecha_upload
  	remove_column :videos, :ruta
  end
end
