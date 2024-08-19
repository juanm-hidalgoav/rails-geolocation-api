class CreateApiKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :api_keys do |t|
      t.references :user, null: false, foreign_key: true
      t.string :key, null: false, unique: true
      t.timestamp :expires_at
      t.timestamp :last_used_at
      t.timestamp :revoked_at
      t.string :scopes
      t.string :description
      t.timestamps
    end
  end
end