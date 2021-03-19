class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.time :from, null: false
      t.time :to, null: false
      t.string :day
      t.references :class_room, foreign_key: true, null: false
      t.references :teacher_subject, foreign_key: true, null: false
      t.timestamps
    end
  end
end
