class CreateLocation < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :russian_name
      t.string :location_type
      t.string :lat
      t.string :lon

      t.timestamps
    end

    add_index :locations, :name
    add_index :locations, :russian_name
    add_index :locations, :location_type
  end
end
