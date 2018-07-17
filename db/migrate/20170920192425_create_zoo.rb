class CreateZoo < ActiveRecord::Migration[5.1]
  def up
    create_table :zoos do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_index :zoos, :name, unique: true
  end

  def down
    drop_table :zoos
  end
end
