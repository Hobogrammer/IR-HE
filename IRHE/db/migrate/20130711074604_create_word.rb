class CreateWord < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :term
      t.string :reading
      t.string :definition
      t.string :sentence
      t.string :tags, :array => true
      t.integer :user_id
      t.integer :text_id

      t.timestamps
    end
  end
end
