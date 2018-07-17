class CreateWhitelistedEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :whitelisted_emails do |t|
      t.string :email, null: false
    end

    add_index :whitelisted_emails, :email, unique: true
  end
end
