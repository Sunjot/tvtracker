class AddPosterToShows < ActiveRecord::Migration[5.0]
  def change
    add_column :shows, :poster, :string
  end
end
