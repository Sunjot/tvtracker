class AddShowIdsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :show_ids, :text
  end
end
