class CreateAnimal < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE TYPE animal_gender AS ENUM('male', 'female');
    SQL

    create_table :animals do |t|
      t.string :name, null: false
      t.string :species, null: false
      t.column :gender, :animal_gender, null: false
      t.references :zoo, index: true
      t.timestamps
    end
  end

  def down
    drop_table :animals

    execute <<-SQL
      DROP TYPE animal_gender;
    SQL
  end
end
