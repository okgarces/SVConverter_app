class NombreDbVideo < ActiveRecord::Migration
  def change
  	add_column :videos, :nombre, :string
  end
end
