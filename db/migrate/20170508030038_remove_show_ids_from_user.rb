class RemoveShowIdsFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :show_ids, :text
  end
end
