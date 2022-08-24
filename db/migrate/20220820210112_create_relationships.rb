class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :user
      t.references :follower, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :relationships, [:user_id, :follower_id], unique: true
  end
end
