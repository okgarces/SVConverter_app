class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :nombre
      t.integer :usuario_id
      t.datetime :fecha_upload
      t.string :mensaje
      t.integer :estado
      t.datetime :fecha_publicado
      t.string :ruta

      t.timestamps
    end
  end
end
