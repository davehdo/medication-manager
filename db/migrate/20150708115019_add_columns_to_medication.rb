class AddColumnsToMedication < ActiveRecord::Migration
  def change
    add_column :medications, :description, :text
    add_column :medications, :side_effects, :text
  end
end
