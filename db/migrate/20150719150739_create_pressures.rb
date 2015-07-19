class CreatePressures < ActiveRecord::Migration
  def change
    create_table :pressures do |t|
      t.integer :systolic
      t.integer :diastolic
      t.datetime :taken_at

      t.timestamps null: false
    end
  end
end
