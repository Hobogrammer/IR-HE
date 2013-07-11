class CreateText < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.integer :user_id
      t.string :title
      t.text :content
      t.string :language
      t.string :tags, :array => true
      t.boolean :share, default: false

      t.timestamps
    end
  end
end
