class AddShowsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :shows, :integer
  end
end
