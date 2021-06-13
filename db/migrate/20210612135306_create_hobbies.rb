class CreateHobbies < ActiveRecord::Migration[6.0]
  def change
    create_table :hobbies do |t|
      t.string :title,           null: false
      t.date :release_date,      null: false
      t.string :recommended,     null: false
      t.string :synopsis,        null: false
      t.references :user,        foreign_key: true
      t.bigint :category_id,     foreign_key: true

      t.timestamps
    end
  end
end