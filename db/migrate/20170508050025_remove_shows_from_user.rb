class RemoveShowsFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :shows, :integer
  end
end
