class CreatePlaylistTable < ActiveRecord::Migration[6.0]
  def change
      create_table :playlists do |table|
        table.string :name
        
        table.references :user
        table.references :song
      end
  end
end
