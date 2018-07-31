class CreateCoords < ActiveRecord::Migration[5.0]
  def change
    create_table :coords do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
