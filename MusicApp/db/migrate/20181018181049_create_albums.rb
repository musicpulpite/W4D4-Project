class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.integer :year, null: false
      t.boolean :live_album
      t.integer :band_id, null: false
      t.index [:title, :band_id], unique: true
    end
  end
end
