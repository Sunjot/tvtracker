class CreateShowsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :shows_users do |t|
      t.references :user, foreign_key: true
      t.references :show, foreign_key: true
    end
  end
end
