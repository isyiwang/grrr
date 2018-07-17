class CreateAuthentications < ActiveRecord::Migration[5.1]
  def up
    create_table :authentications do |t|
      t.string :type, null: false # polymorphism (STI)
      t.string :uid, null: false
      t.string :encrypted_token, null: false
      t.string :encrypted_token_iv, null: false
      t.string :encrypted_refresh_token
      t.string :encrypted_refresh_token_iv
      t.jsonb :aux_data
      t.integer :expires_at
      t.references :user, index: true
      t.string :encrypted_kms_dek
      t.timestamps null: false
    end

    add_index :authentications, [:type, :uid], unique: true
    add_index :authentications, :uid
  end

  def down
    drop_table :authentications
  end
end
